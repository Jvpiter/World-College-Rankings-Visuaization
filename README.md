# World-College-Rankings-Visuaization
 Completion Date: May 2016
 
 Colleges are mapped in the form of networks using 2015 data from the Center for World University Rankings (http://cwur.org/).
 
 More info on http://ronaldlitvak.com/college-rankings/
 
 
 -------------------------------------------------------------------------------------------------------------------------------------

Contents:


Influence.R 
- Generates the network associated with the "influence" of the colleges. Should be run last.


Education.R 
- Generates the network associated with the "education quality" of the colleges. Should be run last.


ToMatrix.py 
- The main script that changes the dataset into an appropriate adjacency matrix. The script was run 6 times with slight changes to generate 6 different adjacency matrices. These were union merged in Influence.R and Education.R. 


Other .py files 
- Used for preprocessing. Returns txt files used by Influence.R and Education.R. Can be combined into one script.


PDF files
- Network sample images. The college "influence" network and a community graph. Generated with Gephi using R output.
