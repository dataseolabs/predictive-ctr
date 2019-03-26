library(dplyr)

## % of SEO traffic to each page per keyword
scdata <- scdata %>% 
  group_by(page) %>% 
  mutate(clickPage = clicks / sum(clicks)) %>%
  ungroup()


