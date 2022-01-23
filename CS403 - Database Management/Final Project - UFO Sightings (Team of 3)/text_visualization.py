# -*- coding: utf-8 -*-
"""
Created on Wed May  5 19:08:31 2021

Author: Skyler McMullen
"""

import pg8000
import getpass
import re
from tqdm import tqdm
from collections import Counter
import matplotlib.pyplot as plt
import numpy as np
import operator

def getSummaries():
    user = input('Username: ')
    password = getpass.getpass()
    #Ex. "SELECT summary FROM final_project WHERE Summary is not NULL AND state = 'CO'"
    query = input('Query: ') 
    
    
    db = pg8000.connect(user=user, password=password, host='codd.mines.edu', port=5433, database='csci403')   #Credentials/info to access the db
    cursor = db.cursor()
    cursor.execute(query)
    summary_data = cursor.fetchall()
    return summary_data

def getAllWords(data):
    words_pattern = '[a-z]+'
    text = ''
    print('Gathering all words: ')
    for d in tqdm(data):
        text += ' ' + d[0].lower()
    words = re.findall(words_pattern, text, flags=re.IGNORECASE)
    return words

def getCounts(data):
    counts = Counter(data)
    # remove all common words
    common_words = getCommonWords()
    for word in common_words:
        del counts[word]
    return counts

def getCommonWords():
    words = open('1-1000.txt').read().splitlines()
    return [word.lower() for word in words]

def plot_top_n(num_words, filename):
    words = getAllWords(getSummaries())
    counts = getCounts(words)
    sorted_counts = dict(sorted(counts.items(), key=operator.itemgetter(1),reverse=True))
    top100 = list(sorted_counts.items())[:num_words]
    top_words = [item[0] for item in top100]
    top_counts = [item[1] for item in top100]
    
    fig, ax = plt.subplots()
    fig.set_size_inches(10.5, 16.5)
    y_pos = np.arange(len(top_words))
    
    ax.barh(y_pos, top_counts, align='center')
    ax.set_yticks(y_pos)
    ax.set_yticklabels(top_words)
    ax.invert_yaxis()  # labels read top-to-bottom
    ax.set_xlabel('Counts')
    ax.set_title(f'Top {num_words} words in Summaries')
    plt.savefig(filename)
    
if __name__ == "__main__":
    filename = input('Enter name of savefile: ')
    num_words = input('Enter number of words to collect: ')
    plot_top_n(int(num_words), filename)
