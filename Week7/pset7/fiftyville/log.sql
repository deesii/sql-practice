-- Keep a log of any SQL queries you execute as you solve the mystery.

-- what data i have
-- find out more about the crime (July 28 2021 at the Humphrey Street) using the crime scene reports
--
--
-- undersstand what data I have in the database

.schema

-- to see what is in the crime scene reports
-- key info, theft took place at 10:15am
-- bakery is mentioned in the interviews

SELECT description
FROM crime_scene_reports
WHERE year = 2021
AND month = 7
AND day = 28
AND street = 'Humphrey Street';

-- from this query, want to look at the three witness interiews that took place at 10:15 am filtering by bakery in the transcript, using the key word bakery as mentioned in the crime scene report

SELECT transcript, name
FROM interviews
WHERE year = 2021
AND month = 7
AND day = 28
AND transcript LIKE '%bakery%';

-- from this query, three leads :
--1.Look at security footage from the bakery (time frame of 10:15-10:25) (DONE)
--2. Look at the ATM log before 10:15 am on Leggett Street (note , atm transaction does not have time) (DONE)
--3. Query phone log <1 minute duration (DONE)
--4. Query early flights from Fiftyville and purchse log after 10:15 , flight to be on the 29 July 2023
--5. Pasport number matches the flight = the person who flew
--6. Check the airport destination
--7. the person who assisted: receiver phone number (from the suspect)
--8. join with the people table to get the person ID etc.

-- should be able to piece together the id of the person through the atm transaction, the licence plate , and link the id (passport_number)

-- to see what the contents of the table looked like therefore to contstruc the next query:

SELECT *
FROM atm_transactions
WHERE year = 2021
AND month = 7
AND day = 28
LIMIT 5;

-- seeing what the bank_accounts table looks like:

SELECT *
FROM bank_accounts
LIMIT 5;

-- Look at the atm transaction and link to the bank acount to get the person id before link to the people table so that we can get the license, passport and name.

SELECT atm_transactions.account_number, people.name, people.passport_number, people.license_plate
FROM atm_transactions, bank_accounts, people
WHERE atm_transactions.account_number = bank_accounts.account_number
AND people.id = bank_accounts.person_id
AND atm_transactions.year = 2021
AND atm_transactions.month = 7
AND atm_transactions.day = 28
AND atm_transactions.atm_location = 'Leggett Street'
AND atm_transactions.transaction_type = 'withdraw';

--from the query this identifies 8 people from the ATM transaction therefore look at the next query from the parking lot:
-- seeing what the column contents show

SELECT *
FROM bakery_security_logs
WHERE year = 2021
AND month = 7
AND day = 28
LIMIT 5;


-- further filtering, based on the previous queries

SELECT hour, minute, license_plate
FROM bakery_security_logs
WHERE baking_security_logs.year = 2021
AND baking_security_logs.month = 7
AND baking_security_logs.day = 28
AND baking_security_logs.hour = 10
AND baking_security_logs.minute <= 30
AND baking_security_logs.activity = 'exit';

--joining the bakery security logs to the atm logs

SELECT people.name, people.passport_number, people.license_plate, people.phone_number
FROM atm_transactions, bank_accounts, people, bakery_security_logs
WHERE atm_transactions.account_number = bank_accounts.account_number
AND people.id = bank_accounts.person_id
AND bakery_security_logs.license_plate = people.license_plate
AND atm_transactions.year = 2021
AND atm_transactions.month = 7
AND atm_transactions.day = 28
AND atm_transactions.atm_location = 'Leggett Street'
AND atm_transactions.transaction_type = 'withdraw'
AND bakery_security_logs.year = 2021
AND bakery_security_logs.month = 7
AND bakery_security_logs.day = 28
AND bakery_security_logs.hour = 10
AND bakery_security_logs.minute <= 30
AND bakery_security_logs.activity = 'exit';

--want to now incorporate phone call data
--first see what the phone call columns show
-- and then filter by duration less than a minute

SELECT *
FROM phone_calls
WHERE year = 2021
AND month = 7
AND day = 28;

--duraction is in seconds therefore filter

SELECT caller, receiver
FROM phone_calls
WHERE year = 2021
AND month = 7
AND day = 28
AND duration < 60;

-- add this into the join sql query above to see :

SELECT people.name, people.passport_number, phone_calls.receiver
FROM atm_transactions, bank_accounts, people, bakery_security_logs, phone_calls
WHERE atm_transactions.account_number = bank_accounts.account_number
AND people.id = bank_accounts.person_id
AND bakery_security_logs.license_plate = people.license_plate
AND phone_calls.caller = people.phone_number
AND atm_transactions.year = 2021
AND atm_transactions.month = 7
AND atm_transactions.day = 28
AND atm_transactions.atm_location = 'Leggett Street'
AND atm_transactions.transaction_type = 'withdraw'
AND bakery_security_logs.year = 2021
AND bakery_security_logs.month = 7
AND bakery_security_logs.day = 28
AND bakery_security_logs.hour = 10
AND bakery_security_logs.minute <= 30
AND bakery_security_logs.activity = 'exit'
AND phone_calls.year = 2021
AND phone_calls.month = 7
AND phone_calls.day = 28
AND phone_calls.duration < 60;

-- the query above gives two names with two passport numbers

--see who flew out on on the 29 July 2021, with earliest flight (min. flight hour):

SELECT min(flights.hour), flights.id, flights.destination_airport_id
FROM flights, airports, passengers
WHERE year = 2021
AND flights.origin_airport_id = airports.id
AND flights.id = passengers.flight_id
AND month = 7
AND day = 29
AND airports.city = 'Fiftyville'


--incorporating the above into the larger query, so that hopefully there is only one passport and person remaining

SELECT min(flights.hour), people.name, people.passport_number, phone_calls.receiver, flights.destination_airport_id
FROM atm_transactions, bank_accounts, people, bakery_security_logs, phone_calls, flights, airports, passengers
WHERE atm_transactions.account_number = bank_accounts.account_number
AND people.id = bank_accounts.person_id
AND bakery_security_logs.license_plate = people.license_plate
AND phone_calls.caller = people.phone_number
AND flights.origin_airport_id = airports.id
AND flights.id = passengers.flight_id
AND people.passport_number = passengers.passport_number
AND atm_transactions.year = 2021
AND atm_transactions.month = 7
AND atm_transactions.day = 28
AND atm_transactions.atm_location = 'Leggett Street'
AND atm_transactions.transaction_type = 'withdraw'
AND bakery_security_logs.year = 2021
AND bakery_security_logs.month = 7
AND bakery_security_logs.day = 28
AND bakery_security_logs.hour = 10
AND bakery_security_logs.minute <= 30
AND bakery_security_logs.activity = 'exit'
AND phone_calls.year = 2021
AND phone_calls.month = 7
AND phone_calls.day = 28
AND phone_calls.duration < 60
AND flights.year = 2021
AND flights.month = 7
AND flights.day = 29
AND airports.city = 'Fiftyville';


--finding out the destination airport, from a previous query (hard code)

SELECT city
FROM airports
WHERE id = 4;

-- finding out the receiver (hard code)

SELECT name
    FROM people
        JOIN phone_calls
        ON people.phone_number = phone_calls.receiver
        WHERE phone_calls.receiver = '(375) 555-8161'
        LIMIT 1;

--without need to hard code, finding the name of the accomplice (hard code 8 hour)

SELECT name
    FROM people
        JOIN phone_calls
        ON people.phone_number = phone_calls.receiver WHERE phone_calls.receiver IN
            (SELECT phone_calls.receiver
                FROM atm_transactions, bank_accounts, people, bakery_security_logs, phone_calls, flights, airports, passengers
                    WHERE atm_transactions.account_number = bank_accounts.account_number
                        AND people.id = bank_accounts.person_id
                        AND bakery_security_logs.license_plate = people.license_plate
                        AND phone_calls.caller = people.phone_number
                        AND flights.origin_airport_id = airports.id
                        AND flights.id = passengers.flight_id
                        AND people.passport_number = passengers.passport_number
                        AND atm_transactions.year = 2021
                        AND atm_transactions.month = 7
                        AND atm_transactions.day = 28
                        AND atm_transactions.atm_location = 'Leggett Street'
                        AND atm_transactions.transaction_type = 'withdraw'
                        AND bakery_security_logs.year = 2021
                        AND bakery_security_logs.month = 7
                        AND bakery_security_logs.day = 28
                        AND bakery_security_logs.hour = 10
                        AND bakery_security_logs.minute <= 30
                        AND bakery_security_logs.activity = 'exit'
                        AND phone_calls.year = 2021
                        AND phone_calls.month = 7
                        AND phone_calls.day = 28
                        AND phone_calls.duration < 60
                        AND flights.year = 2021
                        AND flights.month = 7
                        AND flights.day = 29
                        AND airports.city = 'Fiftyville'
                        AND flights.hour = 8)
                LIMIT 1;

--without needing to hard code (hard code earliest flight at 8 hour)

SELECT city
    FROM airports
        WHERE id IN
            (SELECT flights.destination_airport_id
                FROM atm_transactions, bank_accounts, people, bakery_security_logs, phone_calls, flights, airports, passengers
                    WHERE atm_transactions.account_number = bank_accounts.account_number
                        AND people.id = bank_accounts.person_id
                        AND bakery_security_logs.license_plate = people.license_plate
                        AND phone_calls.caller = people.phone_number
                        AND flights.origin_airport_id = airports.id
                        AND flights.id = passengers.flight_id
                        AND people.passport_number = passengers.passport_number
                        AND atm_transactions.year = 2021
                        AND atm_transactions.month = 7
                        AND atm_transactions.day = 28
                        AND atm_transactions.atm_location = 'Leggett Street'
                        AND atm_transactions.transaction_type = 'withdraw'
                        AND bakery_security_logs.year = 2021
                        AND bakery_security_logs.month = 7
                        AND bakery_security_logs.day = 28
                        AND bakery_security_logs.hour = 10
                        AND bakery_security_logs.minute <= 30
                        AND bakery_security_logs.activity = 'exit'
                        AND phone_calls.year = 2021
                        AND phone_calls.month = 7
                        AND phone_calls.day = 28
                        AND phone_calls.duration < 60
                        AND flights.year = 2021
                        AND flights.month = 7
                        AND flights.day = 29
                        AND airports.city = 'Fiftyville'
                        AND flights.hour = 8);