#loading libraries 
pacman::p_load(rgbif, tidyverse)

#extracting occurences for each species as available in gbif
m_reevesii <- occ_search(scientificName = "Mauremys reevesii")
a <- m_reevesii$data %>% 
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

#zero observations 
#e_coli <- occ_search(scientificName = "Escherichia coli")
#k <- e_coli$data %>%
  #as.data.frame()%>% 
  #select(countryCode, genus, species,  decimalLongitude, decimalLatitude) %>%
  #drop_na()

#zero observations 
#s_enetrica <- occ_search(scientificName = "Salmonella	enetrica")$data %>%
#as.data.frame()

d_birchii <- occ_search(scientificName = "Drosophila birchii")
l <- d_birchii$data %>%
  as.data.frame()%>% 
  select(countryCode, genus, species,  decimalLongitude, decimalLatitude) %>%
  drop_na()
#binding all the data together
gbif_data <- bind_rows(a,b,c,d,e,f,g,h,i,j,l) %>%
  drop_na()

#binning data into different temperature zones
regions <- gbif_data %>% 
  mutate(thermal_zone = case_when(between(decimalLatitude, -20, 20.9) ~ "tropical", 
                                  between(decimalLatitude, 21, 40.9) ~ "subtropical",
                                  between(decimalLatitude, -21, -40.9) ~ "subtropical",
                                  between(decimalLatitude, -41, -60.9) ~ "temperate",
                                  between(decimalLatitude, 41, 60.9) ~ "temperate", 
                                  between(decimalLatitude, 61, 90) ~ "arctic", 
                                  between(decimalLatitude, -61, -90) ~ "arctic")) %>%
  mutate(genus = case_when(species == "Caiman latirostris" ~ "Caiman", 
                           species %in% c("Drosophila birchii", "Drosophila melanogaster", 
                                          "Drosophila simulans") ~ "Drosophila", 
                           species == "Escherichia coli " ~ "Escherichia", 
                           species == "Gryllus firmus " ~ "Gryllus",
                           species %in% c("Limnodynastes peronii", 
                                          "Limnodynastes tasmaniensis") ~ "Limnodynastes",
                           species == "Mauremys reevesii" ~ "Mauremys",
                           species == "Plestiodon chinensis " ~ "Plestiodon",
                           species == "Rhodnius prolixus" ~ "Rhodnius",
                           species == "Xylotrechus arvicola" ~ "Xylotrechus")) %>%
  drop_na()

write_csv(regions, "gbif_regiondata.csv")

count<-count(regions, countryCode, thermal_zone, species)
glimpse(regions)
