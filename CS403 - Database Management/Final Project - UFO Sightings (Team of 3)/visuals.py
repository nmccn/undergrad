'''Creating cool visuals for the final project

To run: python3 visuals.py

'''

import pg8000
import getpass
from collections import defaultdict
import pandas as pd
import matplotlib.pyplot as plt
from geopy.geocoders import Nominatim   #For lat/long
import descartes
import geopandas as gpd
from shapely.geometry import Point, Polygon
from pandas import DataFrame
import os
from pyproj import CRS

def getCityState():
    #user = input("Username: ")
    #secret = getpass.getpass()
    db = pg8000.connect(user=user, password=secret, host='codd.mines.edu', port=5433, database='csci403')   #Credentials/info to access the db
    cursor = db.cursor()
    cursor.execute("SELECT city, state FROM final_project WHERE city is not NULL AND state is not NULL")
    location_data = cursor.fetchall()

    return location_data

def locationEval(location_data):
    co_cities = defaultdict(list) #city: numOccurances
    states = defaultdict(list)  #state: numOccurances
    
    for line in location_data:
        city, state = line
        state = state.upper()
        city = city.lower()

        #Updating the states map
        if state in states:
            states[state] = states[state]+1
        elif state != "NULL" and state:
            states[state] = 1
        
        #Updating the cities map
        if state == "CO" and (city in co_cities):
            co_cities[city] = co_cities[city]+1
        elif state == "CO" and city != "null":
            co_cities[city] = 1

    return co_cities, states

def stateTablePlotting(statesDict):
    #Redefine data structure
    state_df = pd.DataFrame(list(statesDict.items()), columns=['state','numOccurancesSeen'])    
    
    '''#Plotting
    states = state_df['state']
    occurances = state_df['numOccurancesSeen']
    fig, ax = plt.subplots(figsize = (10, 13))
    ax.barh(states, occurances)
    ax.grid(b = True, color ='grey', linestyle ='-.', linewidth = 0.5, alpha = 0.2)
    ax.invert_yaxis()   
    ax.set_title('Number of UFO Encounters in Different Regions', loc ='center', )
    ax.set_ylabel('State/Region')
    ax.set_xlabel('Number of Encounters Recorded')
    plt.show()'''

    return state_df
    
def mapPlotting(statesDict, state_df):
    '''
    plt.figure(figsize = (10,10))

    lat_list = []
    long_list = []
    for state in statesDict:
        latitude, longitude = getLatLong(state)
        if latitude != 0 and longitude != 0:
            lat_list.append(latitude)
            long_list.append(longitude)

    image = plt.imread("https://upload.wikimedia.org/wikipedia/commons/f/f3/BlankMap-USA-states.PNG")
    plt.imshow(image, extent=[-160, -70, 20, 60])
    plt.plot(long_list, lat_list, 'o', markersize=5)
    plt.show()
    '''

    lat_list = []
    long_list = []
    for state in statesDict:
        latitude, longitude = getLatLong(state)
        if latitude != 0 and longitude != 0:
            lat_list.append(latitude)
            long_list.append(longitude)
    df = pd.DataFrame(list(zip(lat_list, long_list)), columns = ['Latitude', 'Longitude'])
    crs = {'epsg:4326'}
    #shape_file_path = os.path.abspath("/UnitedStates_Boundary.shp")
    

    image = gpd.read_file("/Users/chloemccaffrey/Documents/School/CSCI403_DatabaseManagement/finalProject/CSCI403_Proj9/Igismap/UnitedStates_Boundary.shp")
    fig,ax=plt.subplots(figsize = (15,15))
    image.plot(ax=ax)
    
    geometry = [Point(xy) for xy in zip(df["Longitude"], df["Latitude"])]
    geo_df = gpd.GeoDataFrame(df, crs=crs, geometry=geometry)
    geo_df.head()

    '''fig,ax=plt.subplots(figsize=(15,15))
    image.plot(ax=ax, alpha=0.4, color='grey')
    geo_df[geo_df].plot(ax=ax, markersize=20,color="blue", marker = "o")
    '''

    
def getLatLong(stateAb):
    capital_dic={
        'AL': 'Montgomery',
        #'AK': 'Juneau',
        'AZ':'Phoenix',
        'AR':'Little Rock',
        'CA': 'Sacramento',
        'CO':'Denver',
        'CT':'Hartford',
        'DE':'Dover',
        'FL': 'Tallahassee',
        'GA': 'Atlanta',
        #'HI': 'Honolulu',
        'ID': 'Boise',
        'IL': 'Springfield',
        'IN': 'Indianapolis',
        'IA': 'Des Monies',
        'KS': 'Topeka',
        'KY': 'Frankfort',
        'LA': 'Baton Rouge',
        'ME': 'Augusta',
        'MD': 'Annapolis',
        'MA': 'Boston',
        'MI': 'Lansing',
        'MN': 'St. Paul',
        'MS': 'Jackson',
        'MO': 'Jefferson City',
        'MT': 'Helena',
        'NE': 'Lincoln',
        'NV': 'Carson City',
        'NH': 'Concord',
        'NJ': 'Trenton',
        'NM': 'Santa Fe',
        'NY': 'Albany',
        'NC': 'Raleigh',
        'ND': 'Bismarck',
        'OH': 'Columbus',
        'OK': 'Oklahoma City',
        'OR': 'Salem',
        'PA': 'Harrisburg',
        'RI': 'Providence',
        'SC': 'Columbia',
        'SD': 'Pierre',
        'TN': 'Nashville',
        'TX': 'Austin',
        'UT': 'Salt Lake City',
        'VT': 'Montpelier',
        'VA': 'Richmond',
        'WA': 'Olympia',
        'WV': 'Charleston',
        'WI': 'Madison',
        'WY': 'Cheyenne'
    }
    
    geolocator = Nominatim(user_agent="my_user_agent")
    country ="US"
    
    if stateAb in capital_dic:
            loc = geolocator.geocode(capital_dic[stateAb]+','+ country)
            #print(str(stateAb) + " " + str(loc.latitude))
    else:
        return 0, 0

    
    return loc.latitude, loc.longitude
        

if __name__ == "__main__":
    location_data = getCityState()      #Getting the data from the csci403 db
    co_cities, states = locationEval(location_data)     #Restructuring the data
    state_df = stateTablePlotting(states)      #Creating a chart of ufos seen per state
    mapPlotting(states, state_df)     #Plotting state occurances on a map







