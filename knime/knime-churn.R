# https://www.knime.org/knime-applications/churn-analysis
# data: http://www.iainpardoe.com/teaching/dsc433/data/Churn.xls
library(readr)
library(dplyr)
library(survival)
library(magrittr)

read_csv("knime/Churn.csv") %>%
  tbl_df %>%
  mutate(censor = Churn == 1) %>%
  survfit(Surv(`Account Length`, censor) ~ 1, data = .) %T>%
  # Looks too smooth to be real subscription data.
  plot() %>%
  summary(times = 100)