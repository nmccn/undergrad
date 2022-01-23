# -*- coding: utf-8 -*-
"""
Created on Wed May  5 22:21:42 2021

Author: Skyler McMullen
"""

import os
import glob
import pandas as pd

os.chdir("C:\\Users\\Skyle\\OneDrive\\Documents\\csm\\spring2021\\database_management\\project9\\events_by_date")

file_extension = '.csv'
all_filenames = [i for i in glob.glob(f"*{file_extension}")]

combined_csv_data = pd.concat([pd.read_csv(f, sep=',') for f in all_filenames], sort=True)

combined_csv_data.to_csv('combined_csv_data.csv', encoding='utf-8')