# Imported libraries
library(tidyverse)
yearly <- read.csv("data/yearly_deaths_by_clinic.csv")
monthly <- read.csv('data/monthly_deaths.csv')
# Start coding here..
monthly <- monthly%>%
mutate(proportion_deaths=births/deaths)
yearly <- yearly%>%
mutate(proportion_deaths=births/deaths)
ggplot(yearly,aes(x=year,y=proportion_deaths,color=clinic))+
geom_line()
ggplot(monthly,aes(x=date,y=proportion_deaths))+
geom_point()
monthly_after <- monthly%>%
	filter(deaths>0,date>='1847-06-01')%>%
	mutate(handwashing_started=TRUE)
monthly_before <- monthly%>%
	filter(deaths>0,date<'1847-06-01')%>%
	mutate(handwashing_started=FALSE)
monthly <- rbind(monthly_before,monthly_after)
monthly_summary <- monthly%>%
	group_by(handwashing_started)%>%
	summarize(mean(proportion_deaths))
monthly_summary
monthly