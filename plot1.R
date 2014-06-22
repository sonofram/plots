## Return a numeric vector of correlations
library(Defaults)
library(data.table)
library(sqldf)
library(ggplot2)


# plot_data argument is function reference that can be loaded by 
# source("plot_data.R") at https://github.com/sonofram/plots/blob/master/plot_data.R
# Function Descption:  Have total emissions from PM2.5 decreased in the United States 
# from 1999 to 2008? Using the base plotting system, make a plot showing the 
#total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008


plot1 <- function(plot_data) {
        
        ##Get data
        
        NEI <- plot_data$get_NEI()
        SCC <- plot_data$get_SCC()
        
        ##sqldf function
        ##Total Year wise
        total_sql <- sqldf("SELECT year,sum(Emissions) as total from NEI group by year")
        
        png(file="plot1.png")
        
        ##Initialize plot
        with(total_sql,plot(year,total,main="Total Emission per Year",
                            type="n",
                            xlim=range(year),
                            ylim=range(total),
                            xlab="Year",
                            ylab =expression("Total "* PM[2.5] * " Emission")))
        
        ##Add lines
        with(total_sql,lines(year,total,type="o", pch=22, lty=1, col="blue"))
        
        ##Close PNG devie
        dev.off()
}