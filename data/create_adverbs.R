# Susan Huotari
# susan.huotari@helsinki.fi
# 24.2.2017
# Wrangling for IODS-final
## The data was collected from the Old Bailey Corpus where adverb-adjective pairs were searched for.
## Then the results were copied into Excel where they were categorized according to the type of adverb used (derived/other)
## and whether the adverb functions as an intesifier.


# IMPORT DATA
adverbs <- read.csv("/Users/susanhuotari/Desktop/adverbs.csv", sep = ";", header = TRUE, na.strings = c("", "NA"))

summary(adverbs)
# the data consists of a total of 23 variables & 7,828 observations...

# The data contains a lot of metadata that is not (or no longer) relevant for the forthcoming study
# Also, NA's in both age' and 'age group' is over 7,000 and should I include them and then remove 
# NA's from the data set, there would be very little data to work with - so I will not include these variables.


# SELECT INDEPENDENT VARIABLES TO KEEP
keep <- c("adverb_type", "intensifier", "part1", "part2", "Year", "Sex", "Class", "Role")
adverbs_new <- select(adverbs, one_of(keep))


# GET RID OF NA's
complete.cases(adverbs_new)
adverbs_new <- adverbs_new[complete.cases(adverbs_new), ]

summary(adverbs_new) # 8 variables and 6,543 observations left


# MODIFY COLUMN NAMES TO MAKE THEM EASIER TO WORK WITH
colnames(adverbs_new)
colnames(adverbs_new)[3] <- "adverb"
colnames(adverbs_new)[4] <- "adjective"
colnames(adverbs_new)[5] <- "year"
colnames(adverbs_new)[6] <- "gender"
colnames(adverbs_new)[7] <- "class"
colnames(adverbs_new)[8] <- "role"

# MODIFY VARIABLE VALUES TO MAKE THEM EASIER TO WORK WITH

# variable: adverb_type
sort(levels(adverbs_new$adverb_type))
levels(adverbs_new$adverb_type) <- c("derived", "simple")

# variable: intensifier
sort(levels(adverbs_new$intensifier))
levels(adverbs_new$intensifier) <- c("no", "yes")

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
write.csv(adverbs_new, file = "OBCadverbs.csv", row.names = F)

