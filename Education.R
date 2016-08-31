library("igraph")

setwd = setwd("C:\\Users\\Leonid\\Desktop\\Stevens - SPRING 2016\\Network Analysis\\Project")

EQdata <- read.csv("EducationQualitymatrix.txt", header=FALSE)
EQdata <- EQdata[1:100,1:100]
EQdata <- as.matrix(EQdata)

AEdata <- read.csv("AlumniEmploymentmatrix.txt", header=FALSE)
AEdata <- AEdata[1:100,1:100]
AEdata <- as.matrix(AEdata)

QFdata <- read.csv("QualityFacultymatrix.txt", header=FALSE)
QFdata <- AEdata[1:100,1:100]
QFdata <- as.matrix(QFdata)

header <- scan("header.txt",what="", sep=",", quote="")
header <- as.list(header)
header <- unlist(header,recursive=F)
header <- header[1:100]

scores <- scan("scores.txt",what="", sep=",", quote="")
scores <- as.numeric(as.list(scores))
scores <- unlist(scores,recursive=F)
scores <- scores[1:100]

countries <- scan("countries.txt",what="", sep=",", quote="")
countries <- as.list(countries)
countries <- unlist(countries,recursive=F)
countries <- countries[1:100]

#Color unique countries
unique(colors)
colorlist <- vector(mode="list", length=length(unique(countries)))
names(colorlist) <- unique(countries)
shadelist <- rainbow(length(unique(countries)))

for(i in 1:length(names(colorlist))){
  colorlist[names(colorlist)[i]] <- shadelist[i]
}

colors <- vector(mode="list", length=length(countries))
for(i in 1:length(countries)){
  colors[i] <- colorlist[countries[i]]
}

colors <- unlist(colors,recursive=F)

EQgraph <- graph_from_adjacency_matrix(EQdata, diag=FALSE,mode="undirected")
AEgraph <- graph_from_adjacency_matrix(AEdata, diag=FALSE,mode="undirected")
QFgraph <- graph_from_adjacency_matrix(QFdata, diag=FALSE,mode="undirected")

graph <- graph.union(EQgraph,AEgraph,QFgraph)

attributes(V(graph))

V(graph)$name <- header
V(graph)$label <- V(graph)$name
V(graph)$color <- colors
V(graph)$size <- setNames(.06* scores,header)
V(graph)$label.cex = .6

#Neighborhood sizes
neighborhood.size(graph, order=1, nodes=V(graph))
V(graph)[neighborhood.size(graph, order=2, nodes=V(graph))==max(neighborhood.size(graph, order=2, nodes=V(graph)))]

#Check neighborhood of specific node
neighborhood.size(graph, order=2, nodes=V(graph)["Harvard University"])

#Graph of entire network
set.seed(123)

plot(graph, layout=layout.fruchterman.reingold(graph, niter=10000),
     vertex.label=ifelse(V(graph)$name %in% c("University of California Davis","Ruprecht Karl University of Heidelberg","University of Southern California","University of Illinois at Urbana Champaign","Kyushu University","Erasmus University Rotterdam","National University of Singapore","University of Notre Dame","University of Copenhagen","Tsinghua University","University of California Irvine","University of Chicago","Johns Hopkins University","Osaka University","University of Colorado Boulder","University of Minnesota Twin Cities","University of Colorado Boulder","University of North Carolina at Chapel Hill","Weizmann Institute of Science","University of Zurich","Waseda University","Imperial College London","Duke University","cole Polytechnique","McGill University","Osaka University","University of Edinburgh","University of Florida","University of British Columbia","University of Copenhagen","University of Rochester","Georgia Institute of Technology","Brown University","Utrecht University","University of Sydney","Tel Aviv University","Emory University","Tsinghua University","Vanderbilt University","National Taiwan University","Tohoku University","University of Arizona","Boston University","University College London", "University of Virginia","Dartmouth College","University of Oxford","Princeton University","Seoul National University","Northwestern University","Stanford University","Yale University","Harvard University","Columbia University", "Kyoto University","New York University", "University of Michigan Ann Arbor"), V(graph)$name, NA),
     edge.width=.05)

title(     main = "Countries: Top 100 Universities by Education Quality, Alumni Employment, Faculty Quality", cex.main = .6)

#all country names
plot(graph, layout=layout.fruchterman.reingold(graph, niter=10000),
     vertex.label=countries, 
     edge.width=.05)


#Neighborhood Graph
graph2 <- graph.neighborhood(graph,order=1,nodes=V(graph)["University of California San Diego"])

plot(graph2[[1]],layout=layout.fruchterman.reingold(graph2[[1]], niter=1000),
     edge.width=2)

#legend
legend(-1.4,-1.2, names(colorlist)[1:7],horiz=TRUE,  # gives the legend appropriate symbols (lines)
       #   text.width=c(0,0.2,0.235,0.35),
       cex=.5, bty = 'n',
       pch=16,col=shadelist[1:7]) # gives the legend lines the 

legend(-1.4,-1.25, names(colorlist)[8:16],horiz=TRUE,  # gives the legend appropriate symbols (lines)
       #   text.width=c(0,0.2,0.235,0.35),
       cex=.5, bty = 'n',
       pch=16,col=shadelist[8:16]) # gives the legend lines the 

legend(-1.4,-1.3, names(colorlist)[17:19],horiz=TRUE,  # gives the legend appropriate symbols (lines)
    #   text.width=c(0,0.2,0.235,0.35),
       cex=.5, bty = 'n',
       pch=16,col=shadelist[17:19]) # gives the legend lines the 

#communities
c1 = cluster_fast_greedy(graph)
c2 = cluster_leading_eigen(graph)
c3 = cluster_edge_betweenness(graph)
c4 = cluster_optimal(graph)

#Communities Plots
V(graph)$label.cex = .6
set.seed(123)
plot(graph, vertex.color=membership(c3), 
     layout=layout.fruchterman.reingold(graph, niter=10000),
     vertex.label=ifelse(V(graph)$name %in% c("University of California Davis","Ruprecht Karl University of Heidelberg","University of Southern California","University of Illinois at Urbana Champaign","Kyushu University","Erasmus University Rotterdam","National University of Singapore","University of Notre Dame","University of Copenhagen","Tsinghua University","University of California Irvine","University of Chicago","Johns Hopkins University","Osaka University","University of Colorado Boulder","University of Minnesota Twin Cities","University of Colorado Boulder","University of North Carolina at Chapel Hill","Weizmann Institute of Science","University of Zurich","Waseda University","Imperial College London","Duke University","cole Polytechnique","McGill University","Osaka University","University of Edinburgh","University of Florida","University of British Columbia","University of Copenhagen","University of Rochester","Georgia Institute of Technology","Brown University","Utrecht University","University of Sydney","Tel Aviv University","Emory University","Tsinghua University","Vanderbilt University","National Taiwan University","Tohoku University","University of Arizona","Boston University","University College London", "University of Virginia","Dartmouth College","University of Oxford","Princeton University","Seoul National University","Northwestern University","Stanford University","Yale University","Harvard University","Columbia University", "Kyoto University","New York University", "University of Michigan Ann Arbor"), V(graph)$name, NA)
     )
title(     main = "Communities: Top 100 Universities by Education Quality, Alumni Employment, Faculty Quality", cex.main = .6)


graph2 <- graph.neighborhood(graph,order=1,nodes=V(graph)["Dartmouth College"])
plot(graph2[[1]], vertex.color=membership(c3), 
     layout=layout.fruchterman.reingold(graph2[[1]], niter=10000))


#Degree Dist
histogram(degree(graph))

V(graph)[neighborhood.size(graph, order=1, nodes=V(graph))==max(neighborhood.size(graph, order=1, nodes=V(graph)))]

degree(graph)["University of California San Diego"]
#18