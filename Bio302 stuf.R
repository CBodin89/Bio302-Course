library("tidyverse")
library("vegan")
library("broom")


%>% #<--- this percentage symbol thingy = ctrl+shift+m, this is called a pipe

data(BCI, package = "vegan")
x11()  #shortkey to open up a plot window (whenever u use this, the next plot you set up will pop up in a new window)

plot(sort(colSums(BCI), decreasing = TRUE))

####One table functions ####
#select, filter, mutate, group_by, summarise, slice, count, arrange, nest

x1 <- colSums(BCI)
x2 <- sort(x1, decreasing = TRUE)
plot(x2)




BCI %>%
  colSUms() %>% 
  sort(decreasing = TRUE) %>% 
  plot()

####reshaping data####
#make tidy data

as_tibble(iris)
iris <- as_tibble(iris)

iris %>%
  select(-Sepal.Length)   # select() is a function to select one or more colums alone when there is a minus in front it shows original tibble WITHOUT Sepal.Length.!!!!!!!

iris %>% select(Sepal.Length:Petal.Length) #now we are showing all columns from Sepal.Length-Petal.Length

#rename function
iris

iris %>%  rename(Sepalmomma.Length = Sepal.Length)
iris %>%  rename(Sepal.Length = Sepal.Length)

iris %>%  filter(Sepal.Length > 5, Petal.Length < 2) %>% 
  select(Sepal.Length, Petal.Length)

iris %>% group_by(Species) %>% 
  summarise(mean_petal_length = mean(Petal.Length), sd_petal_length = sd(Petal.Length)) #now i group by species  and make a new summary from the columns sepal. Mean and standard deviations. "mean_petal_length = " is just a name for columns shown in 

iris %>% mutate(Petal.Area = Petal.Length * Petal.Width) #Made a new column from two columns multiplied together

iris %>% mutate(Species = toupper(Species))  #makes smaller letters bigger


iris %>% group_by(Species) %>% 
  mutate(mean_petal_length = mean(Petal.Length)) %>% 
  mutate(sd_petal_length = sd(Petal.Length)) %>% 
  ungroup()

iris %>% arrange(Petal.Length)
iris %>% arrange(desc(Petal.Length))

iris %>% group_by(Species) %>%
  arrange(Petal.Length) %>% 
  slice(1:3) #Takes the top row (1), Next 3 (:3)

iris %>%  group_by(Species) %>% nest() %>% 
  mutate(mod = map(data, ~lm(Sepal.Length ~ Sepal.Width, data= .))) %>% 
  mutate(coef = map(mod, broom::tidy)) %>% 
  unnest(coef)

#Gather, spread

iris %>% 
  rownames_to_column() %>% 
  gather(key = variable, value = measurement, -Species, -rowname) %>% 
  group_by(Species, variable) %>% 
  summarise(mean(measurement))

x11()
iris %>% 
  rownames_to_column() %>% 
  gather(key = variable, value = measurement, -Species, -rowname) %>% 
  ggplot(aes(x = variable, y = measurement, fill = Species)) + geom_violin()

#changing the data into indivudal names, species, variable and measurement.

#merging two tables

####Two table functions####
#left_join, full_join, semi_join, anti_join

####n table functions####
#bind_rows, bind_cols, crossing