

imr2011 <- read.csv("D:/RLearning/IMRPanel/Datasets/IMR2011.csv", stringsAsFactors = FALSE)
imr2012 <- read.csv("D:/RLearning/IMRPanel/Datasets/IMR2012.csv", stringsAsFactors = FALSE)
imr2013 <- read.csv("D:/RLearning/IMRPanel/Datasets/IMR2013.csv", stringsAsFactors = FALSE)
imr2014 <- read.csv("D:/RLearning/IMRPanel/Datasets/IMR2014.csv", stringsAsFactors = FALSE)

hhi2011 <- read.csv("D:/RLearning/IMRPanel/Datasets/HHI2011.csv", stringsAsFactors = FALSE)
hhi2012 <- read.csv("D:/RLearning/IMRPanel/Datasets/HHI2012.csv", stringsAsFactors = FALSE)
hhi2013 <- read.csv("D:/RLearning/IMRPanel/Datasets/HHI2013.csv", stringsAsFactors = FALSE)
hhi2014 <- read.csv("D:/RLearning/IMRPanel/Datasets/HHI2014.csv", stringsAsFactors = FALSE)

hce2011 <- read.csv("D:/RLearning/IMRPanel/Datasets/HCE2011.csv", stringsAsFactors = FALSE)
hce2012 <- read.csv("D:/RLearning/IMRPanel/Datasets/HCE2012.csv", stringsAsFactors = FALSE)
hce2013 <- read.csv("D:/RLearning/IMRPanel/Datasets/HCE2013.csv", stringsAsFactors = FALSE)
hce2014 <- read.csv("D:/RLearning/IMRPanel/Datasets/HCE2014.csv", stringsAsFactors = FALSE)

cov2011 <- read.csv("D:/RLearning/IMRPanel/Datasets/COV2011.csv", stringsAsFactors = FALSE)
cov2012 <- read.csv("D:/RLearning/IMRPanel/Datasets/COV2012.csv", stringsAsFactors = FALSE)
cov2013 <- read.csv("D:/RLearning/IMRPanel/Datasets/COV2013.csv", stringsAsFactors = FALSE)
cov2014 <- read.csv("D:/RLearning/IMRPanel/Datasets/COV2014.csv", stringsAsFactors = FALSE)

obe2011 <- read.csv("D:/RLearning/IMRPanel/Datasets/OBE2011.csv", stringsAsFactors = FALSE)
obe2012 <- read.csv("D:/RLearning/IMRPanel/Datasets/OBE2012.csv", stringsAsFactors = FALSE)
obe2013 <- read.csv("D:/RLearning/IMRPanel/Datasets/OBE2013.csv", stringsAsFactors = FALSE)
obe2014 <- read.csv("D:/RLearning/IMRPanel/Datasets/OBE2014.csv", stringsAsFactors = FALSE)

pop2011 <- read.csv("D:/RLearning/IMRPanel/Datasets/POP2011.csv", stringsAsFactors = FALSE)
pop2012 <- read.csv("D:/RLearning/IMRPanel/Datasets/POP2012.csv", stringsAsFactors = FALSE)
pop2013 <- read.csv("D:/RLearning/IMRPanel/Datasets/POP2013.csv", stringsAsFactors = FALSE)
pop2014 <- read.csv("D:/RLearning/IMRPanel/Datasets/POP2014.csv", stringsAsFactors = FALSE)

smo2011 <- read.csv("D:/RLearning/IMRPanel/Datasets/SMO2011.csv", stringsAsFactors = FALSE)
smo2012 <- read.csv("D:/RLearning/IMRPanel/Datasets/SMO2012.csv", stringsAsFactors = FALSE)
smo2013 <- read.csv("D:/RLearning/IMRPanel/Datasets/SMO2013.csv", stringsAsFactors = FALSE)
smo2014 <- read.csv("D:/RLearning/IMRPanel/Datasets/SMO2014.csv", stringsAsFactors = FALSE)

emission11_14 <- read.csv("D:/RLearning/IMRPanel/Datasets/emission11_14.csv", stringsAsFactors = FALSE)

#Fixing the broken first column name due to Microsoft Excel's csv "BOM" stuff
Lstate <- list(cov2011 = cov2011, cov2012 = cov2012, cov2013 = cov2013, cov2014 = cov2014, hce2011 = hce2011, hce2012 = hce2012, hce2013 = hce2013, hce2014 = hce2014, hhi2011 = hhi2011, hhi2012 = hhi2012, hhi2013 = hhi2013, hhi2014 = hhi2014, imr2011 = imr2011, imr2012 = imr2012, imr2013 = imr2013, imr2014 = imr2014, pop2011 = pop2011, pop2012 = pop2012, pop2013 = pop2013, pop2014 = pop2014, emission11_14 = emission11_14)
Lstate <- lapply(Lstate, function(x) {names(x)[1] <- "State"; x})
list2env(Lstate, envir = .GlobalEnv)

####Cleaning multiple data frames at once using lists, lapply, and functions

Lcov <- list(cov2011 = cov2011, cov2012 = cov2012, cov2013 = cov2013, cov2014 = cov2014)
Lcov <- lapply(Lcov, function(x)x[-c(1,53),c(1,2,6,10)])
list2env(Lcov, envir = .GlobalEnv)

#Removing United States from States in HCE, HHI, and IMR
Lh_h_i <- list(hce2011 = hce2011, hce2012 = hce2012, hce2013 = hce2013, hce2014 = hce2014, hhi2011 = hhi2011, hhi2012 = hhi2012, hhi2013 = hhi2013, hhi2014 = hhi2014, imr2011 = imr2011, imr2012 = imr2012, imr2013 = imr2013, imr2014 = imr2014)
Lh_h_i <- lapply(Lh_h_i, function(x)x[-1,])
list2env(Lh_h_i, envir = .GlobalEnv)

#Obesity - Removing NAs and Puerto Rico/Guam from the rows. Keeping only the state column and obesity percent column 
obe2014 <- obe2014[-c(53:63),]
obe2013 <- obe2013[-c(53:62),]
obe2012 <- obe2012[-c(53:61),]
obe2011 <- obe2011[-c(53:61),]
Lobe <- list(obe2011 = obe2011, obe2012 = obe2012, obe2013 = obe2013, obe2014 = obe2014)
Lobe <- lapply(Lobe, function(x)x[-1,c(6,15)])
Lobe <- lapply(Lobe, function(x) {names(x) <- c("State", "ObesityRate"); x})
list2env(Lobe, envir = .GlobalEnv)

#Population percentages
Lpop <- list(pop2011 = pop2011, pop2012 = pop2012, pop2013 = pop2013, pop2014 = pop2014)
Lpop <- lapply(Lpop, function(x)x[-c(1,53),-c(5,7,9)])
list2env(Lpop, envir = .GlobalEnv)

#Smoking Rate - Filtering only to "Yes" responses to the BRFSS survey, then removing extraneous columns and rows
Lsmo <- list(smo2011 = smo2011, smo2012 = smo2012, smo2013 = smo2013, smo2014 = smo2014)
Lsmo <- lapply(Lsmo, function(x)x[-c(1,2,3,4,107:121),c(4,8,12)])
Lsmo <- lapply(Lsmo, function(x)x[x$Response == "Yes",])
Lsmo <- lapply(Lsmo, function(x) {names(x) <- c("State", "Response", "SmokingRate"); x})
list2env(Lsmo, envir = .GlobalEnv)

#2011
cbind2011 <- cbind(cov2011, hce2011[2], hhi2011[2], imr2011[2], obe2011[2], pop2011[2:6], smo2011[3], emission11_14[2])
cbind2011$Year <- "2011"
cbind2011$ID <- c(1:51)
colnames(cbind2011)[15] <- "emi_pc"
#2012
cbind2012 <- cbind(cov2012, hce2012[2], hhi2012[2], imr2012[2], obe2012[2], pop2012[2:6], smo2012[3], emission11_14[3])
cbind2012$Year <- "2012"
cbind2012$ID <- c(1:51)
colnames(cbind2012)[15] <- "emi_pc"
#2013
cbind2013 <- cbind(cov2013, hce2013[2], hhi2013[2], imr2013[2], obe2013[2], pop2013[2:6], smo2013[3], emission11_14[4])
cbind2013$Year <- "2013"
cbind2013$ID <- c(1:51)
colnames(cbind2013)[15] <- "emi_pc"
#2014
cbind2014 <- cbind(cov2014, hce2014[2], hhi2014[2], imr2014[2], obe2014[2], pop2014[2:6], smo2014[3], emission11_14[5])
cbind2014$Year <- "2014"
cbind2014$ID <- c(1:51)
colnames(cbind2014)[15] <- "emi_pc"
#Panel data compliation
IMRpd <- rbind(cbind2011, cbind2012, cbind2013, cbind2014)
#Southern dummy variables
IMRpd$dixieSouth <- ifelse(IMRpd$State %in% c("Texas" , "Oklahoma" , "Missouri" , "Arkansas" , "Louisiana" , "Kentucky" , "Tennesee" , "Mississippi" , "Alabama" , "Georgia" , "Florida" , "South Carolina" , "North Carolina" , "Virginia" , "West Virginia"), 1, 0)
IMRpd$deepSouth <- ifelse(IMRpd$State %in% c("Arkansas" , "Louisiana", "Tennesee" , "Mississippi" , "Alabama" , "Georgia", "South Carolina" , "North Carolina"), 1, 0)

















