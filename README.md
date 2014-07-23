BankingDemo
===========

This is an Espresso Logic sample application showing how rules are used to calculate balances, validate transactions and move funds between accounts

##To Install
1) clone this project file to your local drive
2) Deploy the .SQL script to your MySQL database instance (cloud or local)
3) Open your existing Espresso Logic Designer Studio and import the .JSON project file
4) Under the Project selection - change the Authentication provider to Basic
5) Under the Datbase selection - modify the database connection to point to your MySQL instance

##To Run
Click on LiveBrowser and view customers, accounts, and transactions
Transfer money from checking to savings (try to overdraw the account)
In the Logic Design Studio - click on Logs to see a complete trace of SQL and Business logic rules processed for each transaction
