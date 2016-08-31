data = open("data.csv", 'r')
filewriter = open("countries.txt","w")

for line in data:
    line = line.strip()
    elements = line.split(",")
    filewriter.write(elements[2] + ",")

filewriter.close()
data.close()