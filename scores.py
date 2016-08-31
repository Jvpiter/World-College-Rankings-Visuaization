data = open("data.csv", 'r')
filewriter = open("scores.txt","w")

for line in data:
    line = line.strip()
    elements = line.split(",")   
    filewriter.write(elements[12] + ",")
    
filewriter.close()
data.close()