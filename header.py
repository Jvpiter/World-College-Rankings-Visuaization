data = open("data.csv", 'r')
filewriter = open("header.txt","w")

for line in data:
    line = line.strip()
    elements = line.split(",")    
    filewriter.write(elements[1] + ",")

filewriter.close()
data.close()