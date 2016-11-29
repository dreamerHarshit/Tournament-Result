#Tournament Databse Schema 

This is a database schema to store matches between players in a Swiss style tournament .

##Modules Included-
tournament.sql creates the database, tables, and view

tournament.py contains a number of functions to add to and access the database

tournament_test.py contains a number of test functions

##Commands to setup database and run the project

1. cd fullstack-nanodegree-vm/vagrant

2. Run command $ vagrant up  to activate virtual machine

3. After vagrant up run command $ vagrant ssh

4. Now inorder to setup database type command $ psql -f tournament.sql

5. Inorder to run test the project run command $ python tournament_test.py

