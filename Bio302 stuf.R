library("tidyverse")
library("vegan")


%>% #<--- this percentage symbol thingy = ctrl+shift+m, this is called a pipe

data(BCI, package = "vegan")
x11()  #shortkey to open up a plot window (whenever u use this, the next plot you set up will pop up in a new window)

plot(sort(colSums(BCI), decreasing = TRUE))

####One table functions ####
#select, filter, mutate, group_by, summarise, slice, count, arrange, nest

