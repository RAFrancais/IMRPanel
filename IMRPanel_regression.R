


install.packages("plm")
install.packages("ggplot2")
install.packages("ggcorrplot")

install.packages("car")
#panel data regression package
library(plm)
#graphs and charts
library(ggplot2)
library(ggcorrplot)
library(ggthemes)
#animated histograms
library(gganimate)
#"car" is just used for VIF test
library(car)
#case_when function used for the region variable
library(dplyr)
#regression tables and summary statistics
library(huxtable)
library(stargazer)
IMRdf <- read.csv("D:/RLearning/IMRPanel/Datasets/IMRdf.csv", stringsAsFactors = FALSE)


#removing '$' and ',' from HCE and Household_income
IMRdf$HCE <- (gsub("[$]", "", IMRdf$HCE))
IMRdf$HCE <- (gsub("[,]", "", IMRdf$HCE))
IMRdf$Household_Income <- (gsub("[,]", "", IMRdf$Household_Income))

#Changing vectors into numeric
IMRdf$HCE <- as.numeric(IMRdf$HCE)
IMRdf$Household_Income <- as.numeric(IMRdf$Household_Income)

#Replacing rounding done by the KFF using the original source of the ACS community survey
#Originally, these values were listed as "NA" or "< 0.1"
mont11 <- 4403/982854
mont12 <- 4145/990785
mont13 <- 4038/998554
ida12 <- 8821/1567803
ida13 <- 8957/1567803
roundlist <- list(mont11 = mont11, mont12 = mont12, mont13 = mont13, ida12 = ida12, ida13 = ida13)
roundlist <- lapply(roundlist, round, 4)
list2env(roundlist, envir = .GlobalEnv)

IMRdf[27,11] <- mont11
View(IMRdf)
IMRdf[78,11] <- mont12
IMRdf[129,11] <- mont13
IMRdf[64,11] <- ida12
IMRdf[115,11] <- ida13

IMRdf$Black <- as.numeric(IMRdf$Black)
#Log of incomes
IMRdf$loghhi <- log(IMRdf$Household_Income)
IMRdf$logpi <- log(IMRdf$pi_pc)


IMRdf$pi_pc1000 <- IMRdf$pi_pc/1000
IMRdf$HCE1000 <- IMRdf$HCE/1000

IMRdf14 <- IMRdf[IMRdf$Year == 2014,]
IMRsummary <- IMRdf[c(8,4,5,6,17,9,11,15,16)]

##Creating the region factor variable for lsdv

IMRdf$region <- case_when(
  IMRdf$State %in% c('Connecticut', 'Maine','Massachusetts','New Hampshire', 'Rhode Island', 'Vermont') ~ "NewEngland", 
  IMRdf$State %in% c('Delaware', 'District of Columbia', 'Maryland', 'New Jersey', 'New York', 'Pennsylvania') ~ 'Mideast', 
  IMRdf$State %in% c('Illinois', 'Indiana', 'Michigan', 'Ohio', 'Wisconsin') ~ 'GreatLakes', 
  IMRdf$State %in% c('Iowa', 'Kansas', 'Minnesota', 'Missouri', 'Nebraska', 'North Dakota','South Dakota') ~ 'Plains', 
  IMRdf$State %in% c('Alabama','Arkansas','Florida','Georgia','Kentucky','Louisiana','Mississippi','North Carolina','South Carolina','Tennessee','Virginia','West Virginia') ~ 'Southeast', 
  IMRdf$State %in% c('Arizona', 'New Mexico', 'Oklahoma', 'Texas') ~ 'Southwest', 
  IMRdf$State %in% c('Colorado', 'Idaho', 'Montana', 'Utah', 'Wyoming') ~ 'RockyMountain', 
  IMRdf$State %in% c('Alaska', 'California', 'Hawaii', 'Nevada', 'Oregon', 'Washington') ~ 'FarWest', TRUE ~ 'w')


#panel data stuff
IMRpd <- pdata.frame(IMRdf, index=c("ID", "Year"))

random <- plm(IMR ~ Medicaid.Only + Uninsured + HCE1000 + pi_pc1000 + ObesityRate + Black + emi_pc + SmokingRate + southeast, data = IMRpd, index = c("ID", "Year"), model = "random")
summary(random)
original <- lm(IMR ~ HCE1000 + pi_pc1000 + ObesityRate + southeast, data = IMRdf14)
summary(original)
pooled <- plm(IMR ~ Medicaid.Only + Uninsured + HCE1000 + pi_pc1000 + ObesityRate + Black + emi_pc + SmokingRate + southeast, data = IMRpd, index = c("ID", "Year"), model = "pooling")
vif(pooled)
fixed <- plm(IMR ~ Medicaid.Only + Uninsured + HCE1000 + logpi + ObesityRate + Black + emi_pc + SmokingRate, data = IMRpd, index = c("ID", "Year"), model = "within")
summary(fixed)
phtest(fixed,random)

lsdv <- lm(IMR ~ Medicaid.Only + Uninsured + HCE1000 + pi_pc1000 + ObesityRate + Black + White + Hispanic + Asian + emi_pc + SmokingRate + factor(region) + factor(Year), data = IMRdf)

##Histogram
gghist <- ggplot(IMRdf, aes(x = Household_Income)) + geom_histogram(bins = 12, color = "black", fill = "lightblue") + labs(title = "Distribution of Household Income Ranges", x = "Household Income")
gghistpi <- ggplot(IMRdf, aes(x = pi_pc))+ geom_histogram(bins = 12, color = "black", fill = "lightblue") + labs(title = "Distribution of Personal Income Ranges", x = "Personal Income Per Capita")
gghistemi <- ggplot(IMRdf, aes(x = emi_pc)) + geom_histogram(bins = 12, color = "black", fill = "lightblue") + labs(title = "Distribution of Personal Income Ranges", x = "Personal Income Per Capita")
##Animated Histogram
gganim <- gghist + shadow_mark(alpha = 0.3, color = "lightgreen") + transition_states(Year, wrap = FALSE) + ease_aes("cubic-in-out") + ggtitle('Distribution of Household Income', subtitle = 'Year {closest_state}') + theme(plot.title = element_text(size = 20, face = "bold"))
animate(gganim, width = 500, height = 500, end_pause = 30)
anim_save("HHIhistogram.gif", animation = last_animation())
##Animated PIPC histogram
gganim <- gghistpi + shadow_mark(alpha = 0.3, color = "lightgreen") + transition_states(Year, wrap = FALSE) + ease_aes("cubic-in-out") + ggtitle('Distribution of Personal Income', subtitle = 'Year {closest_state}') + theme(plot.title = element_text(size = 20, face = "bold"))
animate(gganim, width = 500, height = 500, end_pause = 30)
#Regression Table and Summary Statistics - Regression Table Depreciated
stargazer(original, fixed, type="html", title="Regression Results", align=TRUE, style="aer")
stargazer(IMRsummary, type = "html", title = "Summary Statistics")

#Correlation matrix
IMRcorr <- IMRdf[,c(4,5,6,7,9,11,15,16)]
IMRcorr <- round(cor(IMRcorr), digit = 2)
ggcorrplot(IMRcorr, hc.order = TRUE, type = "lower", outline.color = "gray", ggtheme = ggplot2::theme_gray(), lab = TRUE, title = "Correlation Between Independent Variables")
#Huxtable regression
huxreg <- huxreg('Cross Sectional IMR' = original, 'Least Squares Dummy Variable' = LSDV, stars = c(`*` = 0.1, `**` = .05, `***` = 0.01), error_pos = 'same')
set_caption(huxreg, "Linear Regressions of Infant Mortality Rate")
huxreg <- set_caption(huxreg, "Linear Regressions of Infant Mortality Rate")
print_html(huxreg)



ggplot(data = IMRdf, aes(x = region, y = IMR, group = region, fill = region)) + geom_boxplot() + labs(title = "Plot of Infant Mortality Rate Across Regions", x = "Region (as defined by the BEA)", y = "IMR (per 1000 infants under 1)")




















