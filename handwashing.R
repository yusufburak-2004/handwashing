

# Imported libraries
library(tidyverse)

# Veri setlerini yükleme
yearly <- read.csv("data/yearly_deaths_by_clinic.csv")
monthly <- read.csv('data/monthly_deaths.csv')

# Aylık veri setine oran sütunu eklemek
monthly <- monthly %>%
  mutate(proportion_deaths = births / deaths)

# Yıllık veri setine oran sütunu eklemek
yearly <- yearly %>%
  mutate(proportion_deaths = births / deaths)

# Yıllık ölüm oranlarını görselleştirme
ggplot(yearly, aes(x = year, y = proportion_deaths, color = clinic)) +
  geom_line()

# Aylık ölüm oranlarını görselleştirme
ggplot(monthly, aes(x = date, y = proportion_deaths)) +
  geom_point()

# Tarihine göre el yıkamanın başladığı ve başlamadığı ayları ayırma
monthly_after <- monthly %>%
  filter(deaths > 0, date >= '1847-06-01') %>%
  mutate(handwashing_started = TRUE)

monthly_before <- monthly %>%
  filter(deaths > 0, date < '1847-06-01') %>%
  mutate(handwashing_started = FALSE)

# Ay bazında özetleme yapma
monthly <- rbind(monthly_before, monthly_after)
monthly_summary <- monthly %>%
  group_by(handwashing_started) %>%
  summarize(mean(proportion_deaths))
