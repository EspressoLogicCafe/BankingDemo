BankingDemo
===========

This is an Espresso Logic sample application showing how rules are used to calculate balances, validate transactions and move funds between accounts - Once you have an Espresso Logic account - follow these simple steps.

###To Install###
1. clone this project file to your local drive
2. Deploy the .SQL script to your MySQL database instance (cloud or local)
3. Open your existing Espresso Logic Designer Studio and import the .JSON project file
4. Under the Project selection - change the Authentication provider to Basic Authentication
5. Under the Database selection - modify the database connection to point to your MySQL instance and make active.

###To Run###
1. Click on LiveBrowser and view customers, accounts, and transactions
2. Transfer money from checking to savings (try to overdraw the account)
3. In the Logic Design Studio - click on Logs to see a complete trace of SQL and Business logic rules processed for each transaction
4. 
##appery.io###
1. upload the zip backup files to your appery.io project
2. change the REST endpoints in each of the services to use your Espresso Logic service endpoint
3. RUn the test in the emulator (see the pdf documentation file).

