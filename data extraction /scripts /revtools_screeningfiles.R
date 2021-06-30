install.packages("revtools")
library(revtools)

#wos search with 106 papers
wos1 <- read_bibliography("thesis_papers106.bib")
view(wos1)
screen_titles(wos1)

#wos search with 354 papers 
wos2<-read_bibliography("354.bib")
screen_titles(wos2)

###read in abstracts for screening
as <- read_csv(file = "wos354_included.csv")
as <- as.data.frame(as)
screen_abstracts(as)


#wos search with 176 papers 
wos176<-read_bibliography("wos176.bib")
screen_titles(wos176)

wos_176 <-read_csv(file = "wos176_included.csv")
wos_176_screen <- as.data.frame(wos_176)
screen_abstracts(wos_176_screen)

#wos search with 2361 papers (part a of e) 
wos2361a<-read_bibliography("wos2361_a.bib")
screen_titles(wos2361a)

