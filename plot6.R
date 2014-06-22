## Return a numeric vector of correlations
library(Defaults)
library(data.table)
library(sqldf)
library(ggplot2)


# plot_data argument is function reference that can be loaded by 
# source("plot_data.R") at https://github.com/sonofram/plots/blob/master/plot_data.R
# Function Descption: 6.Compare emissions from motor vehicle sources in Baltimore City 
# with emissions from motor vehicle sources in Los Angeles County, California (fips == "06037"). 
# Which city has seen greater changes over time in motor vehicle emissions?

plot6 <- function(plot_data) {
        
        #get data.
        NEI <- plot_data$get_NEI()
        SCC <- plot_data$get_SCC()        
        
        ##sqldf function
        total_blt_la_SCC_sql <- sqldf("SELECT fips,SCC,year,sum(Emissions) as total from NEI where (fips = \"24510\" or fips = \"06037\") group by fips,SCC,year")
        
        ##mer
        mrg_data <- merge(total_blt_la_SCC_sql,SCC,by.x="SCC",by.y="SCC",all=FALSE)
        
        ##COal data
        total_motor_sql <- sqldf("SELECT fips,year,sum(total) as total from mrg_data where upper(EI_Sector) like '%VEHICLE%' group by fips,year")
        total_motor_sql$county <- factor(total_motor_sql$fips,levels = c("06037","24510"), labels = c("Los Angles","Baltimore"))
        
        #open png file
        png(file="plot6.png")
        
        g <- ggplot(total_motor_sql,aes(year,total))
        
        p <- g + 
                facet_grid(. ~ county) + 
                geom_point(color="blue",size=4)+ 
                labs(x = "Year", 
                     y = expression("Total "* PM[2.5] * " Emission"),
                     title = "Total Motor Vehicle Emission comparsion") +
                geom_smooth(method="lm",col="red",se=FALSE)+
                coord_cartesian(ylim=range(total_motor_sql$total),xlim=range(total_motor_sql$year))
        
        print(p)
        
        #hist(dt$Global_active_power, col = "red", xlab= "Global Active Power(Kilowatts)", main="Global Active Power" )
        dev.off()
}