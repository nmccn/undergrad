'''To run: python3 uploadFiles.py combinedReports.csv

This file is used to add the data from the csv file into the Mines CSCI 403 db

For accessing the table via the db use both commands:
SET search_path TO myschema, teammate1, public;
ALTER USER teammate1 SET search_path TO myschema, teammate1, public;
'''

import pg8000
import pg8000.native
import getpass
import sys
import csv
import os

#Get the file name and path
def getData():
    file_name = sys.argv[1]                     
    file_path = os.path.abspath(str(file_name))

    return file_name, file_path

#Creating the table in the db
def makeTable(file_name, file_path):
    #Access the db
    #user = input("Username: ")
    #secret = getpass.getpass()
    db = pg8000.connect(user=user, password=secret, host='codd.mines.edu', port=5433, database='csci403')
    #db = pg8000.native.Connection(user=user, password=secret, host='codd.mines.edu', port=5433, database='csci403')
    
    #Create the table
    cursor = db.cursor()
    make_table_query = "CREATE TABLE IF NOT EXISTS final_project (Date varchar(50), City varchar(100), State varchar(25), Shape varchar(25), Duration text, Summary text, Posted date)"
    cursor.execute(make_table_query)
    db.commit()
    
    #Add to the table; bulk loading with copy is weird and has diff process than simply running a query
    '''print(file_path)
    add_data_query = "\COPY final_project FROM '" + file_path + "' DELIMITER ','"
    cursor.execute(add_data_query)  #Execute the query'''

    db.commit()

#Allowing others to access the table
#def shareUse():
    #GRANT USAGE ON SCHEMA chloemccaffrey TO teammate1, teammate2;
    GRANT USAGE ON SCHEMA chloemccaffrey TO skylermcmullen, nmcclellan, mplumb;
    
    #GRANT ALL ON TABLE final_project TO teammate1, teammate2;
    GRANT ALL ON TABLE final_project TO skylermcmullen, nmcclellan, mplumb;
    
if __name__ == '__main__':
    file_Name, file_path = getData()
    makeTable(file_Name, file_path)
    #shareUse()
    






