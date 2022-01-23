# -*- coding: utf-8 -*-
"""
Created on Tue Apr 27 15:42:28 2021

Data Collection File for Project 9

Runs from Command Prompt on Windows

Example:

    python data_collection.py http://www.nuforc.org/webreports/ndxevent.html

        usage: data_collection.py [-h] url [save_path]
    
        Collect and store tables from online html files
        
        positional arguments:
          url         url for table of reports
          save_path   Path to directory where reports will be saved. 
                      Makes directory "./reports", if none spcified
        
        optional arguments:
          -h, --help  show this help message and exit
"""

from Table import Table
from bs4 import BeautifulSoup
import requests
from urllib.parse import urljoin
import pandas as pd
from tqdm import tqdm
import argparse
import os
import shutil

def create_table(table_info):
    # th=table_heading, tr=table_row, td=table_data for what its worth.
    column_headers = [th.get_text().strip() for th in table_info.find("tr").find_all("th")]
    df = pd.DataFrame(columns=column_headers)
    for row in table_info.find_all("tr")[1:]:
        # There may be an easier way to do this, this is creating a dictionary such as {State: CO}
        data = dict(zip(column_headers, (td.get_text() for td in row.find_all("td"))))
        df = df.append(data, ignore_index=True)
    return df

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Collect and store tables from online html files")
    parser.add_argument('url', help='URL for table of reports')
    parser.add_argument('save_path', nargs='?', const=None, help='Path to directory where reports will be saved. Makes directory "./reports", if none spcified', default=None)
    url = parser.parse_args().url
    save_path = parser.parse_args().save_path
    if save_path == None:
        parent_dir = os.path.abspath(os.getcwd())
        save_path = os.path.join(parent_dir, "reports")
        if os.path.isdir(save_path):
            try:
                shutil.rmtree(save_path)
            except OSError as e:
                print("Error: %s : %s" % (save_path, e.strerror))
        os.mkdir(save_path)
    r = requests.get(url)
    html_content = r.content
    page = BeautifulSoup(html_content, 'html.parser')
    # create a list containing tuples of report titles and urls. Ex: ('04/2021', 'http://www.nuforc.org/webreports/ndxe202104.html')
    urls = [(link.text.strip(), urljoin(url, link.get('href'))) for link in page.find_all('a')]
    for title, url in tqdm(urls):
        page = requests.get(url)
        content = BeautifulSoup(page.content, 'html.parser')
        table_info = content.find("table")
        # if a table exists, create the table and store as csv
        if table_info != None:
            t = Table(create_table(table_info))
            t.clean()
            t.save(filename=title.replace("/", "-"), path=save_path)
    