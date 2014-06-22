## Return a numeric vector of correlations
library(Defaults)
library(data.table)
library(sqldf)
library(ggplot2)


# plot_data argument is function reference that can be loaded by 
# source("plot_data.R")
# Function Descption:  4.Across the United States, how have emissions 
# from coal combustion-related sources changed from 1999-2008?


plot5 <- function(plot_data) {
        
        NEI <- plot_data$get_NEI()
        SCC <- plot_data$get_SCC()        
        
        
        ##sqldf function
        total_blt_SCC_sql <- sqldf("SELECT SCC,year,sum(Emissions) as total from NEI where fips = \"24510\" group by fips,SCC,year")
        
        ##mer
        mrg_data <- merge(total_blt_SCC_sql,SCC,by.x="SCC",by.y="SCC",all=FALSE)
        
        ##COal data
        total_motor_sql <- sqldf("SELECT year,sum(total) as total from mrg_data where upper(EI_Sector) like '%VEHICLE%' group by year")
        
        ##opening PNG file
        png(file="plot5.png")
        
        
        g <- ggplot(total_motor_sql,aes(year,total))
        
        p <- g + geom_point(color="blue",size=4)+ labs(x = "Year", 
                                                       y = expression("Total "* PM[2.5] * " Emission"),
                                                       title = "Total Motor Vehicle Emission per Year in Baltimore"
        ) +
                geom_smooth(method="lm",col="red",se=FALSE)+
                coord_cartesian(ylim=range(total_motor_sql$total),xlim=range(total_motor_sql$year))
        
        print(p)
        
        #hist(dt$Global_active_power, col = "red", xlab= "Global Active Power(Kilowatts)", main="Global Active Power" )
        dev.off()
}
