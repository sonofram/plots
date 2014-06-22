## Return a numeric vector of correlations
library(Defaults)
library(data.table)
library(sqldf)
library(ggplot2)

#plot_data stored in plot_data.R
# This function called for first time will loaded NEI and SCC data to 
# memory for further use by plot1.R, plot2.R,plot3.R,plot4.R,plot5.R and
# plot6.R

plot_data <- function() {
        
        NEI <- readRDS("summarySCC_PM25.rds")
        SCC <- readRDS("Source_Classification_Code.rds")

        get_NEI <- function(){
                NEI
        }

        get_SCC <- function(){
                
                SCC
        }
        
        list(get_NEI = get_NEI, get_SCC = get_SCC)

}
