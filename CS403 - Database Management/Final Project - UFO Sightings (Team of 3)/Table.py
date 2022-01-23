"""
Created on Tue Apr 27 15:30:27 2021

Table Class

TODO: describe class
"""

from tabulate import tabulate
from statistics import mean
import re

class Table:
    '''
    Table object to store, clean, and save data collected from tables in html files

    Parameters
    ----------
    data : pandas.DataFrame object
        data structure to store table
    '''
    def __init__(self, data=None):
        self._data = data
        
    @property
    def table(self):
        """
        Getter function for Table data
        
        Returns:
        -------
        pandas.DataFrame object
        """
        return self._table
    
    @table.setter
    def table(self, table):
        """
        Getter function for Table data
        """
        self._table = table
        
    def nullify_empty_strings(self):
        """
        Replaces all empty strings with 'NULL' strings
        
        Anywhere in the dataframe there is a empty string, the element is 
        modified to 'NULL' for when we add the table to psql
        """
        self._data = self._data.replace(to_replace='', value='NULL')
        
    def drop_duplicates(self):
        """
        Drops any duplicate rows in the table, while keeping 1 copy
        """
        self._data.drop_duplicates(keep='first', inplace=True)
        
    def clean_duration(self):
        """
        Cleans Duration column in the table
        
        Strings of event durations are converted to their time in seconds.
        
        Uses regular expresions for pattern regonition of each entry.
        
        Any durations in forms such as:
            1. 5s
            2. 5sec
            3. 5 seconds
            4. 55 minutes
            5. 5.5 hours
            6. 55.55 s
            etc.
        will be converted to their corresponding time in seconds, stored as
        an integer.
        
        Any entries that do not match this pattern are converted to NULL 
        strings. This may need to be changed for when we copy this database 
        into psql. Not sure exatly how the NULLs need to be represented.
        
        TODO: add functionality to convert strings like 'One second' or 'Five minutes'
        """
        interval_pattern = "\d+-\d+"
        sec_pattern = '((\d+)|(\d+\.\d+))(s|sec|second)' 
        min_pattern = '((\d+)|(\d+\.\d+))(m|min|minute)'
        hr_pattern = '((\d+)|(\d+\.\d+))(h|hr|hour)'
        number = "\d+" 
        for index_label, row_series in self._data.iterrows():
            duration = self._data.at[index_label, 'Duration'].strip().replace(' ', '').lower()
            interval_match = re.search(interval_pattern, duration)
            # Check for an interval like "5-10 minutes"
            # Change accordingly to "7.5 minutes"
            if interval_match:
                bounds = interval_match.group(0).split("-")
                e = interval_match.end()
                avg = mean(list(map(int, bounds)))
                duration = str(avg)+duration[e:]
            sec_match = re.search(sec_pattern, duration)
            min_match = re.search(min_pattern, duration)
            hr_match = re.search(hr_pattern, duration)
            if sec_match:
                new_duration = int(re.search(number, sec_match.group(0)).group(0))
                self._data.at[index_label, 'Duration'] = new_duration
            elif min_match:
                new_duration = int(re.search(number, min_match.group(0)).group(0)) * 60
                self._data.at[index_label, 'Duration'] = new_duration 
            elif hr_match:
                new_duration = int(re.search(number, hr_match.group(0)).group(0)) * 60 * 60
                self._data.at[index_label, 'Duration'] = new_duration 
            else:
                self._data.at[index_label, 'Duration'] = "NULL"
                
    def clean(self):
        """
        Aggregate function for the other cleaning functions for simple use
        """
        self.nullify_empty_strings()
        self.drop_duplicates()
        self.clean_duration()
        
    def display(self):
        """
        Display the table in psql format
        """
        print(tabulate(self._data, headers='keys', tablefmt='psql'))
        
    def save(self, filename, path=''):
        """
        Save table as .csv file
        """
        self._data.to_csv(str(path+'\\'+filename+'.csv'), index=False)