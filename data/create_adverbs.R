# Susan Huotari
# susan.huotari@helsinki.fi
# 24.2.2017

# Wrangling for IODS-final

## The data was originally collected from the Old Bailey Corpus where adverb-adjective pairs were searched for. Then the results were copied into Excel where they were refined and categorized.

## In this wranglig scrip I modify the data set further.

library(dplyr)

# IMPORT DATA
adverbs <- read.csv("/Users/susanhuotari/Desktop/adverbs.csv", sep = ";", header = TRUE, na.strings = c("", "NA"))

str(adverbs)
# the data consists of a total of 23 variables & 7,828 observations...

# The data contains a lot of metadata that is not (or no longer) relevant for the forthcoming study. Also, NA's in both age' and 'age group' is over 7,000 and should I include them and then remove NA's from the data set, there would be very little data to work with - so I will not include these variables.


# SELECT ONLY INTENSIFIERS
sort(levels(adverbs$intensifier))
adverbs_new <- adverbs %>% filter(intensifier == "Intensifier") # 5,668 obs. left


# SELECT VARIABLES TO KEEP
keep <- c("adverb_type", "part1", "part2", "Year", "Sex", "Class", "Role")
adverbs_new <- dplyr::select(adverbs_new, one_of(keep))


# GET RID OF NA's
complete.cases(adverbs_new)
adverbs_new <- adverbs_new[complete.cases(adverbs_new), ]

str(adverbs_new) # 7 variables and 4,667 observations left


# MODIFY COLUMN NAMES TO MAKE THEM EASIER TO WORK WITH
colnames(adverbs_new)
colnames(adverbs_new)[2] <- "adverb"
colnames(adverbs_new)[3] <- "adjective"
colnames(adverbs_new)[4] <- "year"
colnames(adverbs_new)[5] <- "gender"
colnames(adverbs_new)[6] <- "class"
colnames(adverbs_new)[7] <- "role"

# MODIFY VARIABLE VALUE LABELS TO MAKE THEM EASIER TO WORK WITH

# variable: adverb_type
sort(levels(adverbs_new$adverb_type))
levels(adverbs_new$adverb_type) <- c("derived", "simple")

# variable: gender
sort(levels(adverbs_new$gender))
levels(adverbs_new$gender) <- c("female", "male")

# variable: class
sort(levels(adverbs_new$class))
levels(adverbs_new$class) <- c("higher", "lower")

# variable: role
sort(levels(adverbs_new$role))
levels(adverbs_new$role) <- c("def", "int", "jud", "law", "per", "vic", "wit")


# SAVE IN DATA FOLDER
write.csv(adverbs_new, file = "adverbs.csv", row.names = F)

