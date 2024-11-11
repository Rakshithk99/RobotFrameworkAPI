import json
from multiprocessing.forkserver import read_signed

from docutils.parsers import null

f = open("./ExpectedResponses/Expected1.txt", "r")
response_data= f.read()
# Assuming you have a JSON response stored in a variable called `response_data`

# Convert the JSON response to a string
#json_string = json.dumps(response_data)

#print(response_data.get("Data"))
print(response_data)
print(type(response_data))
