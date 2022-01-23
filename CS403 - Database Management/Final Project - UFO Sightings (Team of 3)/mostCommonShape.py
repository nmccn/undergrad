import pg8000
import getpass
from collections import defaultdict
import pandas as pd
import matplotlib.pyplot as plt

def getData():
    #user = input("Username: ")
    #secret = getpass.getpass()
    db = pg8000.connect(user=user, password=secret, host='codd.mines.edu', port=5433, database='csci403')   #Credentials/info to access the db
    cursor = db.cursor()
    cursor.execute("SELECT shape FROM final_project WHERE shape is not NULL AND shape not like 'Other' AND shape not like 'Unknown' AND shape not like 'NULL';")
    shape_data = cursor.fetchall()

    shapeDict = defaultdict(list)  #shape: numOccurances
    for row in shape_data:
        shape = row[0]

        if shape in shapeDict:
            shapeDict[shape] = shapeDict[shape]+1
        else:
            shapeDict[shape]=1
        
    return shapeDict

def plotCommonShapes(shapeDict):
    shape_df = pd.DataFrame(list(shapeDict.items()), columns=['shape','numOccurancesSeen'])    
    
    #Plotting
    shape = shape_df['shape']
    occurances = shape_df['numOccurancesSeen']
    fig, ax = plt.subplots(figsize = (10, 13))
    ax.barh(shape, occurances)
    ax.grid(b = True, color ='grey', linestyle ='-.', linewidth = 0.5, alpha = 0.2)
    ax.invert_yaxis()   
    ax.set_title('Number of UFO Shapes Reported', loc ='center', )
    ax.set_ylabel('Shape')
    ax.set_xlabel('Quantity Seen')
    plt.show()

if __name__ == "__main__":
    shapeDict = getData()
    plotCommonShapes(shapeDict)










