from bs4 import BeautifulSoup
import requests
import csv

def get_html(url):
    page = requests.get(url)
    HTML = BeautifulSoup(page.content, 'html.parser')
    return HTML

def find_table(html):
    table_info = html.find("table")
    return table_info

# Provides 1 page worth of tabulated data in the form of a giant dictionary. 
def create_table1(table_info):
    # th=table_heading, tr=table_row, td=table_data for what its worth.
    column_headers = [th.get_text().strip() for th in table_info.find("tr").find_all("th")]
    dataset = []
    for row in table_info.find_all("tr")[1:]:
        # There may be an easier way to do this, this is creating a dictionary such as {State: CO}
        data = dict(zip(column_headers, (td.get_text() for td in row.find_all("td"))))
        dataset.append(data)
    create_csv(column_headers, dataset)
    return dataset

# Write out the created dictionary as a csv (to be imported psq)
def create_csv(column_headers, dataset):
    with open('data.csv', 'w') as csv_data:
        writer = csv.DictWriter(csv_data, column_headers)
        writer.writeheader()
        for data in dataset:
            writer.writerow(data)

# Was an alternative form I had thought of using, not all that useful.
# def create_table2(table_info):
#     # the headers will be first row of our dataset
#     column_headers = [th.get_text().strip() for th in table_info.find("tr").find_all("th")]
#     # Find the dimensions of the required table
#     rows, cols = (len(table_info.find_all("tr")), len(column_headers))
#     dataset = [[None for i in range(cols)] for j in range(rows)]
#     # Need to change the loop structure a bit and just fill in the dataset from table_info
#     # for row in table_info.find_all("tr")[1:]:
#     #     # I don't think we actually need to do this, this is creating a dictionary such as {State: CO}
#     #     data = dict(zip(column_headers, (td.get_text() for td in row.find_all("td"))))
#     #     dataset.append(data)
#     return dataset

# Driver code to test the functions. 
data = get_html('http://www.nuforc.org/webreports/ndxlCO.html')
table_info = find_table(data)
data_ = create_table1(table_info)
print(data_)
