# Susan Huotari
# susan.huotari@helsinki.fi
# 24.2.2017

# Wrangling for IODS-final

## The data was originally collected from the Old Bailey Corpus where adverb-adjective pairs were searched for. Then the results were copied into Excel where they were refined and categorized.

## In this wranglig scrip I modify the data set further.


# IMPORT DATA
adverbs <- read.csv("/Users/susanhuotari/Desktop/adverbs.csv", sep = ";", header = TRUE, na.strings = c("", "NA"))

str(adverbs)
# the data consists of a total of 23 variables & 7,828 observations...

# The data contains a lot of metadata that is not (or no longer) relevant for the forthcoming study. Also, NA's in both age' and 'age group' is over 7,000 and should I include them and then remove NA's from the data set, there would be very little data to work with - so I will not include these variables.


# SELECT ONLY INTENSIFIERS
sort(levels(adverbs$intensifier))
adverbs <- adverbs %>% filter(intensifier == "Intensifier") # 5,668 obs. left


# SELECT VARIABLES TO KEEP
library(dplyr)
keep <- c("adverb_type", "part1", "part2", "Year", "Sex", "Class", "Role")
adverbs <- dplyr::select(adverbs, one_of(keep))


# GET RID OF NA's
complete.cases(adverbs)
adverbs_new <- adverbs[complete.cases(adverbs), ]

str(adverbs_new) # 7 variables and 4,667 observations left


# MODIFY COLUMN NAMES TO MAKE THEM EASIER TO WORK WITH
colnames(adverbs)
colnames(adverbs)[2] <- "adverb"
colnames(adverbs)[3] <- "adjective"
colnames(adverbs)[4] <- "year"
colnames(adverbs)[5] <- "gender"
colnames(adverbs)[6] <- "class"
colnames(adverbs)[7] <- "role"

# MODIFY VARIABLE VALUE LABELS TO MAKE THEM EASIER TO WORK WITH

# variable: adverb_type
sort(levels(adverbs$adverb_type))
levels(adverbs$adverb_type) <- c("derived", "simple")

# variable: gender
sort(levels(adverbs$gender))
levels(adverbs$gender) <- c("female", "male")

# variable: class
sort(levels(adverbs$class))
levels(adverbs$class) <- c("higher", "lower")

# variable: role
sort(levels(adverbs$role))
levels(adverbs$role) <- c("def", "int", "jud", "law", "per", "vic", "wit")

# REORDER LEVELS IN ADVERB_TYPE
adverbs$adverb_type <- factor(adverbs$adverb_type, levels = c("simple", "derived"))


# SAVE IN DATA FOLDER
write.csv(adverbs_new, file = "OBCadverbs.csv", row.names = F)

