# https://community.watsonanalytics.com/watson-analytics-blog/predictive-insights-in-the-telco-customer-churn-data-set/
# https://community.watsonanalytics.com/wp-content/uploads/2015/03/WA_Fn-UseC_-Telco-Customer-Churn.csv
library(readr)
library(dplyr)
library(survival)
library(magrittr)

read_csv("ibm/WA_Fn-UseC_-Telco-Customer-Churn.csv") %>%
  tbl_df %>%
  mutate(censor = Churn == "No") %>%
  survfit(Surv(tenure, censor) ~ 1, data = .) %T>%
  # too smooth to be real subscription data
  plot(mark.time = F) %>%
  summary()