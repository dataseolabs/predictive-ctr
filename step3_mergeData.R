library(dplyr)

## join data on page
joined_data <- gadata %>% 
  left_join(scdata, by = c(landingPagePath = "page")) %>%
  mutate(sessionEst = clickPage*sessions,
         accuracyEst = ((sessionEst / clicks) - 1))

## we only want clicks over 0, and get rid of a few columns.
tidy_data <- joined_data %>% 
  filter(clicks > 0) #%>% 
  #select(-sessions) 


