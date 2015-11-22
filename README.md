BankingDemo
===========

This is an CA Live API Creator sample application showing how rules are used to calculate balances, validate transactions and move funds between checking and savings accounts - Once you have an API Server account - follow these simple steps.

###To Install###
1. clone this project file to your local drive
2. Deploy the .SQL script to your MySQL database instance (cloud or local)
3. Open your existing API Creator and import the .JSON project file (Import)
4. Under the Data Sources/Database selection - modify the database connection to point to your SQL instance and make active.
5. Under the API Properties selection - change the Authentication provider to Basic Authentication

###To Run###
1. Click on Data Explorer and enter a new customer, check and savings accounts, and transactions (fund your accounts)
2. Transfer money from checking to savings (try to overdraw the account)
3. In the API Creator - click on Logs to see a complete trace of SQL and Rules processed for each transaction

###appery.io###
1. upload the zip backup files to your appery.io project
2. change the REST endpoints in each of the services to use your cloud API Creator/Server service endpoint
3. Run the test in the emulator (see the pdf documentation file).

