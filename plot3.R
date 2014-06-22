## Return a numeric vector of correlations
library(Defaults)
library(data.table)
library(sqldf)
library(ggplot2)


# plot_data argument is function reference that can be loaded by 
# source("plot_data.R")
# Function Descption:  3.Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, which of these four sources have seen decreases in emissions from 1999-2008 for Baltimore City? Which have seen increases in emissions from 1999-2008? 
# Use the ggplot2 plotting system to make a plot answer this question.


plot3 <- function(plot_data) {
        
        ##Get data
        
        NEI <- plot_data$get_NEI()
        SCC <- plot_data$get_SCC()        
        
        
        ##sqldf function
        total_blt_src_sql <- sqldf("SELECT type,year,sum(Emissions) as total from NEI where fips = \"24510\" group by type,year")
        
        png(file="plot3.png")
        
        
        g <- ggplot(total_blt_src_sql,aes(year,total))
        
        p <- g + geom_line(aes(color=type)) + labs(x = "Year", 
                                                   y = expression("Total "* PM[2.5] * " Emission"),
                                                   title = "Total Emission per Year per Source in Baltimore"
        ) +
                coord_cartesian(ylim=range(total_blt_src_sql$total))     
        
        
        print(p)
        
        dev.off()
}