---------------------
Generall information
---------------------
Spring 2021 CSCI403 Project 9 - 'Create' (An open ended project to find/manipulate some dataset)
Project working with a large set of data regarding UFO sightings. 
 
Contributors: Chloe McCaffrey, Matt Plumb, Nic McClellan, Skyler McMullen

Data Obtained from: 
	http://www.nwlink.com/~ufocntr/ 
	http://www.nuforc.org/webreports.html 

There were no restraints on the data due to licensing.

The data is loaded in the Skyler McMullen schema in the table called final_project. As a backup, it is also in schema chloemccaffrey as a table called final_project.


----------------
About the Files
----------------
* scrape.py was used to scrape the datasets from the website.
* data_collection.py was used to clean the data obtained from the website.
* All of the csv files obtained from the online database were stored in the reports folder.
* The combined reports were stored in the combinedReports.csv file.
* uploadFiles.py was used to create the table in psql and attempted to add in the data (failed, so data was added via psql command line).
* visuals.py was used to work with the geographic analysis and visual aid.
* mostCommonShape.py was used to analyze the data shape section and determine what shape was the most common shape reported. 
* text_visualization.py was used to analyze the word counts from the comments and then create a visual aid for this information. 
* 1-1000.txt is the text file that was created from isolating the words in the comments section. This file was used to determine the words that were used the most often in the comments. 
* The final write up is called finalProject.pdf

Enjoy!
 

