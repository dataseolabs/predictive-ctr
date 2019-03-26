library(searchConsoleR)
library(googleAnalyticsR)
library(urltools)

ga_auth()

## account_list will have a column called "viewId"
account_list <- ga_account_list()
account <- as.data.frame(account_list)

## replace with your viewID
ga_id <- VOTRVIEWID

## date range to fetch
start <- as.character(Sys.Date() - 200)
end <- as.character(Sys.Date() - 3)

## Using new GA v4 API
## GAv4 filters
google_seo <- filter_clause_ga4(list(dim_filter("medium", 
                                    "EXACT", 
                                    "organic"),
                         dim_filter("source", 
                                    "EXACT", 
                                    "google")),
                    operator = "AND")

max_results <- 200000

## Getting the GA data

gadata <- google_analytics(ga_id,
                     date_range = c(start,end),
                     metrics = c("sessions",
                                 "pageviews"),
                     dimensions = c("landingPagePath"),
                     dim_filters = google_seo,
                     max = max_results)


#search console
scr_auth()


## Getting the Search Console data
scdata <- search_analytics("VOTRESITE", 
                           startDate = start, endDate = end,
                           dimensions = c("page","query"),
                           rowLimit = max_results,
                           aggregationType = "byPage",
                           walk_data = "byBatch")


## get urls in same format
## gadata has urls www.example.com/pagePath
## scdata has urls in http://www.example.com/pagePath
domainparse <- url_parse(scdata[1,]$page)
domainname <- paste0(domainparse["scheme"],"://",domainparse["domain"])
scdata$page <- gsub(domainname,"",scdata$page)

