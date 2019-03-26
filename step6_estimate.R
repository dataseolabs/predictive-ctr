


predict_click <- tidy_data %>% 
  mutate(positionRound = round(position)) %>%
  left_join(click_curve, by=c(position = "position")) %>%
  mutate(sessionsEst1 = sessionEst * CTR1,
         sessionsEst1.lower = sessionsEst1 * CTR1.lower,
         sessionsEst1.upper = sessionsEst1 * CTR1.upper,
         sessionsEst1.change = sessionsEst1 - sessionEst )



estimates <- predict_click %>% 
  select(landingPagePath, query, clicks, impressions, 
         ctr, position, sessions, sessionEst, sessionsEst1, 
         sessionsEst1.change, sessionsEst1.lower, sessionsEst1.upper, accuracyEst) %>%
  
  arrange(desc(sessionsEst1)) %>% 
  
  dplyr::filter(sessionsEst1.change > 0, 
                clicks > 10)




est_plot <- ggplot(estimates[1:20,], 
                   aes(reorder(query, sessionsEst1), 
                       sessionsEst1, 
                       ymax = sessionsEst1.upper, 
                       ymin =  sessionsEst1.lower))
est_plot <- est_plot + theme_minimal() + coord_flip()
est_plot <- est_plot + geom_crossbar(aes(fill = cut(accuracyEst, 3, labels = c("Good","Ok","Poor"))), 
                                     alpha = 0.7, show.legend = FALSE)
est_plot <- est_plot + scale_x_discrete(name = "Query")
est_plot <- est_plot + scale_y_continuous(name = "Potentiel")
est_plot <- est_plot + scale_y_continuous(name = "Estimation des sessions SEO pour la première place sur Google")
# est_plot <- est_plot + theme(axis.text.y = element_blank())
est_plot <- est_plot + geom_label(aes(label = round(position)), hjust = "center")
#est_plot <- est_plot + scale_y_discrete(expand = c(1,1))
est_plot <- est_plot + ggtitle("Potentiel SEO ( de la position courante )")
est_plot

print(est_plot)

