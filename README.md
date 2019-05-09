BankingDemo
===========

This is an Layer7 Live API Creator sample application showing how rules are used to calculate balances, validate transactions and move funds between checking and savings accounts - Once you have an API Server account - follow these simple steps.

## Installation
1. clone this project file to your local drive
```aidl
git clone https://github.com/EspressoLogicCafe/BankingDemo.git
```
2. Deploy the BankingDemoMySQLV3.sql script to your MySQL database instance (cloud or local)
3. Logon on to your existing Live API Creator and import the .JSON or .Zip project file (Import)
```aidl
LAC use Banking Demo.json
LAC version 5.2 or later use Banking Demo-v5.2zip
```
4. Under the Data Sources/Database selection - modify the database connection to point to your SQL instance and make active.
5. Under the API Properties selection - change the Authentication provider to Basic Authentication
6. In the Schema menu - press the RELOAD SCHEMA

## To Run
1. Click on Data Explorer and enter a new customer, checking and savings accounts, and checking transactions (fund your accounts)
2. Transfer money from checking to savings (try to overdraw the account)
3. In the API Creator - click on Logs to see a complete trace of SQL and Rules processed for each transaction

## Review
1. Look at the menu Rules and review sums, counts, validations, and events.
2. Review the logs after transfering funds from checking to savings.
