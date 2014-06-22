## Return a numeric vector of correlations
library(Defaults)
library(data.table)
library(sqldf)
library(ggplot2)
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

plot1 <- function(plot_data) {
        
        ##Get data
        
        NEI <- plot_data$get_NEI()
        SCC <- plot_data$get_SCC()

        ##sqldf function
        ##Total Year wise
        total_sql <- sqldf("SELECT year,sum(Emissions) as total from NEI group by year")
        
        png(file="plot1.png",width=480,height=480)
        
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

plot2 <- function(plot_data) {

        ##Get data
        
        NEI <- plot_data$get_NEI()
        SCC <- plot_data$get_SCC()        
        
        ##sqldf function
        total_blt_sql <- sqldf("SELECT year,sum(Emissions) as total from NEI where fips = \"24510\" group by year")
        
        #Opening PNG file
        png(file="plot2.png",width=480,height=480)
        
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
        png(file="plot5.png",width=480,height=480)
        
        
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
        total_motor_sql$county <- factor(t$fips,levels = c("06037","24510"), labels = c("Los Angles","Baltimore"))
        
        #open png file
        png(file="plot6.png",width=480,height=480)
        
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