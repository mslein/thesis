#grabbing data from rgbif 
#extracting occurences for each species as available in gbif
pacman::p_load(rvest, rgbif, tidyverse)
c_reevesii <- occ_search(scientificName = "Chinemys reevesii")
a <- c_reevesii$data %>% 
  as.data.frame()%>% 
  select(countryCode, genus, species,  decimalLongitude, decimalLatitude) %>%
  drop_na()

x_arvicola <- occ_search(scientificName = "Xylotrechus arvicola")
b <- x_arvicola$data %>% 
  as.data.frame()%>% 
  select(countryCode, genus, species,  decimalLongitude, decimalLatitude) %>%
  drop_na()

g_firmus <- occ_search(scientificName = "Gryllus firmus")
c <- g_firmus$data %>% 
  as.data.frame()%>% 
  select(countryCode, genus, species,  decimalLongitude, decimalLatitude) %>%
  drop_na()

l_peronii <- occ_search(scientificName = "Limnodynastes	peronii")
d <- l_peronii$data %>% 
  as.data.frame() %>% 
  select(countryCode, genus, species,  decimalLongitude, decimalLatitude) %>%
  drop_na()

l_tasmaniensis <- occ_search(scientificName = "Limnodynastes	tasmaniensis")
e <- l_tasmaniensis$data %>% 
  as.data.frame()%>% 
  select(countryCode, genus, species,  decimalLongitude, decimalLatitude) %>%
  drop_na()

d_simulans <- occ_search(scientificName = "Drosophila simulans")
f <- d_simulans$data %>%
  as.data.frame()%>% 
  select(countryCode, genus, species,  decimalLongitude, decimalLatitude) %>%
  drop_na()

r_prolixus <- occ_search(scientificName = "Rhodnius	prolixus")
g <- r_prolixus$data %>%
  as.data.frame()%>% 
  select(countryCode, genus, species,  decimalLongitude, decimalLatitude) %>%
  drop_na()

c_latirostris <- occ_search(scientificName = "Caiman latirostris")
h <- c_latirostris$data %>%
  as.data.frame()%>% 
  select(countryCode, genus, species,  decimalLongitude, decimalLatitude) %>%
  drop_na()

d_melanogaster <- occ_search(scientificName = "Drosophila melanogaster")
i <- d_melanogaster$data %>%
  as.data.frame()%>% 
  select(countryCode, genus, species,  decimalLongitude, decimalLatitude) %>%
  drop_na()

p_chinensis <- occ_search(scientificName = "Plestiodon chinensis")
j <- p_chinensis$data %>%
  as.data.frame()%>% 
  select(countryCode, genus, species,  decimalLongitude, decimalLatitude) %>%
  drop_na()

#no country column 
e_coli <- occ_search(scientificName = "Escherichia 	coli")
k <- e_coli$data %>%
  as.data.frame()%>% 
  select(countryCode, genus, species,  decimalLongitude, decimalLatitude) %>%
  drop_na()

#zero observations 
s_enetrica <- occ_search(scientificName = "Salmonella	enetrica")$data %>%
  as.data.frame()

d_birchii <- occ_search(scientificName = "Drosophila birchii")
l <- d_birchii$data %>%
  as.data.frame()%>% 
  select(countryCode, genus, species,  decimalLongitude, decimalLatitude) %>%
  drop_na()
#binding all the data together to write to csv 
gbif_data <- bind_rows(a,b,c,d,e,f,g,h,i,j,k,l)
write_csv(gbif_data, "gbif_data.csv")


#plotting up data 
ggplot(gbif_data, aes(x=decimalLongitude, y=decimalLatitude, color=species))+
  geom_rect(aes(xmin = -Inf, xmax = Inf, ymin = -15, ymax = 15),
            alpha = 0.2,
            fill = "red")+
  geom_rect(aes(xmin = -Inf, xmax = Inf, ymin = 15, ymax = 35),
            alpha = 0.2,
            fill = "yellow")+
  geom_rect(aes(xmin = -Inf, xmax = Inf, ymin = -35, ymax = -15),
            alpha = 0.2,
            fill = "yellow")+
  geom_rect(aes(xmin = -Inf, xmax = Inf, ymin = 35, ymax = 55),
            alpha = 0.2,
            fill = "green")+
  geom_rect(aes(xmin = -Inf, xmax = Inf, ymin = -55, ymax = -35),
            alpha = 0.2,
            fill = "green")+
  geom_rect(aes(xmin = -Inf, xmax = Inf, ymin = 55, ymax = 70),
            alpha = 0.2,
            fill = "blue")+
  geom_rect(aes(xmin = -Inf, xmax = Inf, ymin = -70, ymax = -55),
            alpha = 0.2,
            fill = "blue")+
  geom_point(alpha = 0.5)

?geom_rect








