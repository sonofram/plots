README - Generateing Plots for Explanatory Analysis
========================================================

One data load R scripts created

6 plogtting R script created

plot_data.R - function plot_data() 
-----------

When plot_data() function called for first time will load NEI and SCC dataset and can be further referenced in all plotting R scripts (plot1.R, plot2.R, plot3.R, plot4.R, plot5.R and plot6.R)

working direcotry: Current working directory will be used as base directory to search for file
holding dataset NEI and SCC

Loading NEI and SCC once in memory will improve performance for plot generating script.


```{r}

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


```

plot1.R - function plot1(plot_data)
--------

plot1.R holds function plot1(plot_data). This function call will generate plot1.png in working directory.


plot2.R - function plot1(plot_data)
--------

plot2.R holds function plot2(plot_data). This function call will generate plot2.png in working directory.


plot3.R - function plot3(plot_data)
--------

plot3.R holds function plot3(plot_data). This function call will generate plot3.png in working directory.


plot4.R - function plot4(plot_data)
--------

plot4.R holds function plot4(plot_data). This function call will generate plot4.png in working directory.


plot5.R - function plot5(plot_data)
--------

plot5.R holds function plot5(plot_data). This function call will generate plot5.png in working directory.


plot6.R - function plot6(plot_data)
--------

plot6.R holds function plot6(plot_data). This function call will generate plot6.png in working directory.


STEPS TO RUN SCRIPTS
========================================================

Step#initiatilize
-----------------

```{r}

source("plot_data.R")
source("plot1.R")
source("plot2.R")
source("plot3.R")
source("plot4.R")
source("plot5.R")
source("plot6.R")

```

Step#Initialize data
--------------------

```{r}
plot_data <- plot_data()

```
Step#Generate plot1.png
--------------------

```{r}

plot1(plot_data)


```

Step#Generate plot2.png
--------------------

```{r}

plot2(plot_data)


```

Step#Generate plot3.png
--------------------

```{r}

plot3(plot_data)


```


Step#Generate plot4.png
--------------------

```{r}

plot4(plot_data)


```


Step#Generate plot5.png
--------------------

```{r}

plot5(plot_data)


```


Step#Generate plot6.png
--------------------

```{r}

plot6(plot_data)


```
