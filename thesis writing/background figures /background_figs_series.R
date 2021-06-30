install.packages("colorednoise")
library(colorednoise)
library(tidyverse)
library(cowplot)
####long time series######
#generating time series for several years 
red <- colored_noise(timesteps = 365, mean = 0.5, sd = 0.2, phi = 0.9)
white <-colored_noise(timesteps = 365, mean = 0.5, sd = 0.2, phi = 0)
blue<-colored_noise(timesteps = 365, mean = 0.5, sd = 0.2, phi = -0.9)
t<-seq(0, 364, 1)
diurnal<-sin(t)
diurnal<-data.frame(t, diurnal)
#generating time to go along x axis
time<-c(1:365)
#combining time and all noise colors into one data frame
rainbow<-data.frame(red, white, blue, time, diurnal)
#data tidying from above generation
rainbow<-rainbow %>% gather(type, temperature_change, red, white, blue, diurnal)
#filtering out by type for plots 
red<-rainbow %>% filter(type == "red")
white<-rainbow %>% filter(type == "white")
diurnal<-rainbow %>% filter(type == "diurnal")
#plotting all noise colors across time
red_series<-ggplot(red, aes(y=temperature_change, x=time))+
  geom_line(alpha=0.8, color="firebrick3")+
  theme_bw()
white_series<-ggplot(white, aes(y=temperature_change, x=time))+
  geom_line(alpha=0.8, color="gray53")+
  theme_bw()
diurnal_series<-ggplot(diurnal, aes(y=temperature_change, x=time))+
  geom_line(alpha=0.8, color="yellow3")+
  theme_bw()
plot_grid(red_series, white_series, diurnal_series,labels=c("A", "B", "C"), ncol=1, nrow=3)
###spectral density
### estimate the spectral density for red first 
mspect <- spectrum(red$temperature_change, plot=FALSE)
delta <- 1
specx <- mspect$freq/delta
specy <- 2*mspect$spec
spectral_red <- data.frame(specx = mspect$freq/delta, specy = specy)
 #then make a plot with these calcs on the x andy 
spec_red<-spectral_red %>% 
  ggplot(aes(x = specx, y = specy)) + geom_line(color="firebrick3") +
  geom_smooth(method = "lm", se = FALSE, color = "black") +
  scale_y_log10() +
  scale_x_log10()+
  ylab("Spectral density") +
  xlab("Frequency (1/days)")+
  theme_bw()
#repeat estimate for white 
mspectW <- spectrum(white$temperature_change, plot=FALSE)
deltaW <- 1
specxW <- mspectW$freq/deltaW
specyW <- 2*mspectW$spec
spectral_white <- data.frame(specxW = mspectW$freq/deltaW, specyW = specyW)
#repeat plot again for white
spec_white<-spectral_white %>% 
  ggplot(aes(x = specxW, y = specyW)) + geom_line(color="gray53") +
  geom_smooth(method = "lm", se = FALSE, color = "black") +
  scale_y_log10() +
  scale_x_log10()+
  ylab("Spectral density") +
  xlab("Frequency (1/days)")+
  theme_bw()
#repeat estimate for diurnal
mspectD <- spectrum(diurnal$temperature_change, plot=FALSE)
deltaD <- 1
specxD<- mspectD$freq/deltaD
specyD <- 2*mspectD$spec
spectral_diurnal <- data.frame(specxD = mspectD$freq/deltaD, specyD = specyD)
#repeat plot again for diurnal
spec_diurn<-spectral_diurnal %>% 
  ggplot(aes(x = specxD, y = specyD)) + geom_line(color="yellow3") +
  geom_smooth(method = "lm", se = FALSE, color = "black") +
  scale_y_log10() +
  scale_x_log10()+
  ylab("Spectral density") +
  xlab("Frequency (1/days)")+
  theme_bw()
#plot them all in a series 
plot_grid(spec_red, spec_white, spec_diurn,labels=c("A", "B", "C"), ncol=1, nrow=3)