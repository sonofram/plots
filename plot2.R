## Return a numeric vector of correlations
library(Defaults)
library(data.table)
library(sqldf)
library(ggplot2)


# plot_data argument is function reference that can be loaded by 
# source("plot_data.R")
# Function Descption:  2.Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") 
# from 1999 to 2008? Use the base plotting system to make a plot answering this question

plot2 <- function(plot_data) {
         
        ##Get data
        
        NEI <- plot_data$get_NEI()
        SCC <- plot_data$get_SCC()        
        
        ##sqldf function
        total_blt_sql <- sqldf("SELECT year,sum(Emissions) as total from NEI where fips = \"24510\" group by year")
        
        #Opening PNG file
        png(file="plot2.png")
        
        ##Initialize plot
        with(total_blt_sql,plot(year,total,main="Total Emission per Year in Baltimore",
                                type="n",
                                xlim=range(year),
                                ylim=range(total),
                                xlab="Year",
                                ylab =expression("Total "* PM[2.5] * " Emission")))
        
        ##Add lines
        with(total_blt_sql,lines(year,total,type="o", pch=22, lty=1, col="blue"))
        
        
        
        dev.off()
}
