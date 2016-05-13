# https://www.sgi.com/tech/mlc/db/churn.all
# https://blog.cloudera.com/blog/2016/02/how-to-predict-telco-churn-with-apache-spark-mllib/
library(readr)
library(dplyr)
library(survival)
library(magrittr)

read_csv("cloudera/churn.all", col_names = c(
  "state",
  "account length",
  "area code",
  "phone number",
  "international plan",
  "voice mail plan",
  "number vmail messages",
  "total day minutes",
  "total day calls",
  "total day charge",
  "total eve minutes",
  "total eve calls",
  "total eve charge",
  "total night minutes",
  "total night calls",
  "total night charge",
  "total intl minutes",
  "total intl calls",
  "total intl charge",
  "number customer service calls",
  "churned"
)) %>%
  tbl_df %>%
  mutate(censor = churned == "True.") %>%
  survfit(Surv(`account length`, censor) ~ 1, data = .) %T>%
  # too smooth to be real subscription data
  plot(mark.time = F) %>%
  summary()