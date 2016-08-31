"""This script converts the original World University Rankings dataset, from the "data.csv" file,
    into an adjacency matrix. This particular script focuses on creating an adjacency matrix
    for universities that fall within the same ranking for "Patent" production. However, this
    basic script was reused multiple times for other categories and then union merged into 
    new matrices using R. This script returns the "Patentsmatrix.txt", a comma-delimited matrix."""

data = open("data.csv",'r')
file_writer = open("Patentsmatrix.txt", "w")

def find_group(ranking,base=5):
    """Returns which group a college belongs to.
    
    Keyword arguments:
    ranking -- Specific ranking of interest to group colleges.
    base -- How many colleges in one group (default 5).   
    """
    return int(float(ranking)/base) * base

#Debug can be ignored or removed. Used for setting number of observations in the new matrix.
debug = 0
for record in data:
    
    #Strip, split, and perform some basic cleaning on the elements of each record. 
    record = record.strip()
    record_elements = record.split(",")
    ranking = int(record_elements[11].replace("+",""))
    
    #Because we have to loop through the same data again we must open the same dataset again, renamed "data2.csv".
    data_copy = open("data2.csv","r")
    
    #Second loop compares every single record's ranking against all the other records in the same dataset.
    subtotal = 0
    for record_copy in data_copy:
        record_copy=record_copy.strip()
        record_copy=record_copy.split(",")
        ranking_copy = int(record_copy[11].replace("+",""))
        if find_group(ranking-1) == find_group(ranking_copy-1):
            same_group = "1"
        else:
            same_group = "0"   
                
        #subtotal used to make sure that there is no comma at the end of each adjacency matrix row.
        subtotal = subtotal + 1
        if subtotal == 1000:
            file_writer.write(same_group)
        else:
            file_writer.write(same_group + ",")
            
    file_writer.write("\n")
    data_copy.close()
    
    debug = debug + 1
    if debug == 1000:
        break
        
data.close()
file_writer.close()
