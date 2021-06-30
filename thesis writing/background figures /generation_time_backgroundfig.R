library(tidyverse)
library(cowplot)
library(png)


#generating generation time data 
a<-sample(0.5:10, 80, replace = T) 
b<-sample(10:100, 35, replace = T) 
c<-sample(100:5000, 10, replace =T)
generation_time<-c(a, b, c)
d<-sample(1:10, 100, replace = T)
e<-sample(10:30, 20, replace = T)
f<-sample(30:90, 5, replace = T)
flucuation_period <- c(f, e, d)
phase<-data.frame(generation_time, flucuation_period)
p<-ggplot(phase, aes(y=flucuation_period, x=generation_time))+
  geom_point(alpha=0.8, color ="grey25")+
  scale_x_log10()+
  scale_y_log10()+
  geom_vline(xintercept=1, color = "powderblue", size =2)+
  geom_vline(xintercept=10, color = "darkseagreen3", size =2)+
  geom_vline(xintercept=100, color ="lightslateblue", size = 2)+
  geom_vline(xintercept=4000, color ="hotpink3", size = 2)+
  geom_hline(yintercept = 1, color = "yellow3", size = 20, alpha=0.4)+
  geom_hline(yintercept = 10, color ="gray53", size =10, alpha=0.4)+
  geom_hline(yintercept = 8.5, color ="firebrick3", size =10, alpha=0.4)+
  xlab("Generation time (days)")+
  ylab("Fluctuation period (days)")+
  theme_bw(base_size=18)
  
 

  


