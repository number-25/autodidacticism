# Part 1 code - Beta trials 

pollutantmean <- function(direct, id) {
    for (i in 1:length(id)){
      read.csv(file = id.csv) 
    }
   
}

col
colSums(colulmn)
extension <- ".csv"

fileNames <- paste(id, extension)
for (fileNames in direct){
    f <- read.csv(fileNames, header = TRUE) 
    fsum <- colSums(summ$col, na.rm = TRUE) 
    ncols < length(summ$col, !is.na(col)) 
}  

OR
colMeans(summ$col, na.rm = TRUE)


### Full code Part 1

pollu <- function(direct, id, mineral) {
    extension <- ".csv" 
    path <- paste0(getwd(), "/", direct) # helps to provide full file path
    opendata <- data.frame()  
    
    for (i in id) {
      if (i < 10) {
    #fileNames <- paste("/00", as.character(i), extension)
    dataraw <- read.csv(paste(path, "/00", as.character(i), extension, sep = ""), header = TRUE, 
                        as.is = TRUE)
      opendata <- rbind(opendata, dataraw) # or popdata <- rbind(open...)
      }
      
      else if (i < 100){
    #fileNames <- paste0("/0", as.character(i), extension)
    dataraw <- read.csv(paste(path, "/0", as.character(i), extension , sep = ""), header = TRUE, 
                        as.is = TRUE)
      opendata <- rbind(opendata, dataraw)
      }
     
       else {
    #fileNames <- paste0("/", as.character(i), extension)
    dataraw <- read.csv(paste(path, "/", as.character(i), extension, sep = ""), header = TRUE, as.is = TRUE)
      opendata <- rbind(opendata, dataraw)
      }
    }
    #return(popdata)
    return(mean(opendata[,mineral], na.rm = TRUE))
}

# Add a direct function? 


if list.files("specdata") == files 

for (f in fileNames){
  summ <- read.csv(direct[f], header = TRUE)
  colmean <- colMeans(summ$col, na.rm = TRUE)
  colmean




Good progress - use sources here 
colSums
https://www.rdocumentation.org/packages/base/versions/3.6.2/topics/colSums
https://stackoverflow.com/questions/17500679/length-of-columns-excluding-na-in-r

Looping
https://gis.stackexchange.com/questions/231601/looping-over-several-input-files-in-r
https://stackoverflow.com/questions/32498595/looping-through-all-files-in-a-directory-in-r
https://libredd.it/r/rstats/comments/ipef7h/r_loop_with_multiple_csv_files/
https://statisticsglobe.com/r-write-read-multiple-csv-files-for-loop
https://stackoverflow.com/questions/19722945/column-means-over-multiple-files


  
### Part 2 

## Demonstrate it on a single case 

# Load the .csv file as a test 
dftest <- read.csv("specdata/001.csv", header = TRUE)

# Create a logical vector from the complete.cases - each respective
# column-row will contain TRUE if the cases are complete, and 
# FALSE is the values are missing 
mem <- complete.cases(dftest)

# This creates a data frame from the values we're looking to extract
open <- data.frame(id = dftest$ID[1], 
                   nobs = c(nrow(dftest[mem,]))) # nrow calculate from subset 

## Final script 

complete <- function(direct, id = 1:332) {
    path <- paste0(getwd(), "/", direct, "/") # Assign path 
    dataset <- data.frame()
    for (i in id){
        if (i < 10){
        csv <- read.csv(paste(path, "00", as.character(i), ".csv", sep = ""), 
                        header = TRUE, as.is = TRUE)  
        #comcases <- complete.cases(csv)
        #opendata <- data.frame(id = csv[['ID'[1]]], 
                               #nobs = c(nrow(csv[comcases,])))
        } # first if conditional
        
        else if (i < 100){
        csv <- read.csv(paste(path, "0", as.character(i), ".csv", sep = ""), 
                        header = TRUE, as.is = TRUE)  
        #comcases <- complete.cases(csv)
        #opendata <- data.frame(id = csv[['ID'[1]]],
                               #nobs = c(nrow(csv[comcases,])))
        } # else if condition 
        
        else {
        csv <- read.csv(paste(path, as.character(i), ".csv", sep = ""), 
                        header = TRUE, as.is = TRUE)  
        #comcases <- complete.cases(csv)
        #opendata <- data.frame(id = csv[['ID'[1]]],
                               #nobs = c(nrow(csv[comcases,])))
        } # else condition
      
      nobs <- sum(complete.cases(csv))
      dati <- data.frame(i, nobs)
      dataset <- rbind(dataset,dati) # Must be an updating data frame - 
                                     # so that looping will work on it 
      
    } # for bracket       
    return(dataset)
} # last bracket
  

### Part 3 



## Demonstrate it on a single case 

threshold = 50 
open <- read.csv("specdata/001.csv", header = TRUE)
openc <- complete.cases(open)


if (nrow(open[openc,]) > threshold) # or if (sum(complete.cases)) > 
    sulfate <- open[openc,]$sulfate 
nitrate <- open[openc,]$nitrate
cor(sulfate, nitrate)
  

# can do 
sum(complete.cases(data)) # instead of (nrow(open[openc,]) 







## Final script

corr <- function(direct, threshold = 0) {
  path = paste0(getwd(), "/", direct, "/")
  corvec <- NULL # empty vector 
  filenames <- list.files(path = paste0(getwd(), "/", direct, "/"), 
                          pattern = "*.csv", full.names = TRUE)
  
  for (f in seq_along(filenames)){
  #for (i in fileNames){
    data1 <- read.csv(filenames[f], header = TRUE, 
                      as.is = TRUE)
    #datacom <- complete.cases(data1)
    #data2 <- data1[datacom,]
    
    data2 <- data1[complete.cases(data1),]
    if (nrow(data2) > threshold) {
      corvec <- c(corvec, cor(data2[,"sulfate"], data2[,"nitrate"]))  
    }         # if bracket
  }           # for bracket 
  
  return(corvec)
} # Final bracket
  

  
  
  
data2 <- data1[complete.cases(data1),]
if (nrow(data1[complete.cases(data1),]) > threshold) {
  corvec <- c(corvec, cor(data2[,"sulfate"], data2[,"nitrate"]))  
}         # if bracket
}           # for bracket 


