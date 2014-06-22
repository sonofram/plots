## Return a numeric vector of correlations
library(Defaults)
library(data.table)
library(sqldf)
library(ggplot2)


# plot_data argument is function reference that can be loaded by 
# source("plot_data.R") at https://github.com/sonofram/plots/blob/master/plot_data.R
# Function Descption:  4.Across the United States, how have emissions 
# from coal combustion-related sources changed from 1999-2008?


plot4 <- function(plot_data) {
        ##Get data
        
        NEI <- plot_data$get_NEI()
        SCC <- plot_data$get_SCC()        
        
        ##sqldf function
        total_SCC_sql <- sqldf("SELECT SCC,year,sum(Emissions) as total from NEI group by SCC,year")
        
        ##mer
        mrg_data <- merge(total_SCC_sql,SCC,by.x="SCC",by.y="SCC",all=FALSE)
        
        ##COal data
        total_coal_sql <- sqldf("SELECT year,sum(total) as total from mrg_data where upper(EI_Sector) like '%COAL%' group by year")
        
        ##open png file.
        png(file="plot4.png",width=480,height=480)
        
        
        g <- ggplot(total_coal_sql,aes(year,total))
        
        p <- g + geom_point(color="blue",size=4)+ labs(x = "Year", 
                                                       y = expression("Total "* PM[2.5] * " Emission"),
                                                       title = "Total Coal Combustion Emission per Year in USA"
        ) +
                geom_smooth(method="lm",col="red",se=FALSE)+
                coord_cartesian(ylim=range(total_coal_sql$total),xlim=range(total_coal_sql$year))
        
        print(p)
        
        dev.off()
}
