                
# STAT-547M Homework 08 Repository of Rebecca Asiimwe 

## Theme: Making a Shiny app
[<img align ="right" src="https://github.com/STAT545-UBC-students/hw08-rasiimwe/blob/master/plugin/Screen%20Shot%202018-11-17%20at%2011.07.32%20PM.png" width="450" height="250"/>](https://github.com/STAT545-UBC-students/hw08-rasiimwe/blob/master/plugin/Screen%20Shot%202018-11-17%20at%2011.07.32%20PM.png)
### Assignment Overview 
[Shiny](https://shiny.rstudio.com) is an R package that makes it easy for us to build interactive web applications using R. It is available on CRAN and can be installed using:

```r
install.packages("shiny")
```
Shiny's awesomeness ca help us:
* Host standalone apps on a webpage or embed them in R Markdown documents or build dashboards 
* embed CSS themes, htmlwidgets, and JavaScript actions within Shiny apps for flexibility
* develop highly interactive apps and output changes as users modify inputs, without requiring a reload of the browser
* tap into Shiny's very attractive user interfaces (based on Twitter Bootstrap) and the customizable slider widgets with support animations
* enjoy the super fast data transfer between a browser and R
* tap into the reactive programming model that helps us focus on the key application code without worrying about background subroutines and lots of code.
* develop interfaces for our R packages
* and lastly, build websites

### The Developed Shiny App
The developed Shiny app is a supplementary implementation to [Dean Attalis’s]( https://deanattali.com/blog/building-shiny-apps-tutorial) BC Liquor [app]( https://deanattali.com/blog/building-shiny-apps-tutorial/#12-final-shiny-app-code) 

As a key deliverable for this assignment the developed Shiny app is hosted at [shinyapps.io](http://www.shinyapps.io) and can be assessed through this [link](https://explom.shinyapps.io/BCL-app/).


### Some of the key features added to the BC Liquor app:
1. **Image inclusion** of the BC Liquor Store. Out of preference, this was added to my dashboardSidebar.

2. Inclussion of an **interactive table** using `DT::renderDataTable()` from the DT package. Included was also a caption, title, a table style, change in text and column header colours, a specification of pageLength e.t.c. 

3. Inclussion of a **download** button to allow users download the results.

4. Inclussion of a **additional plot parameters**. Here I implemented the `colourpicker` package to select plot colors

5. Inclussion of **dropdownMenus, icons and messages**

6. Inclusion of **tabBox() and tabpanel()** to have plots in different box tabls. 

7. Inclusion of **CSS defined styles** 

8. The usage of **shinydashboard** and most of it's features skins. Themes were tested using `shinythemes::themeSelector()`

**Please visit the app for the implementation of more awesome features.** 

### App source code:
The code that generates my app can be found [here](https://github.com/STAT545-UBC-students/hw08-rasiimwe/blob/master/app/app.R)


### App dataset used:
The dataset used to generate my Shiny app is available at [OpenDataBC](https://deanattali.com/files/bcl-data.csv")


### Repo Navigation:- Please visit the following main files :point_down::

|   **Homework Files**   | **Description** |
|----------------|------------|
|[Link to homework8](http://stat545.com/Classroom/assignments/hw08/hw08.html)|This file contains homework 8 tasks and their descriptions|
|[README.md](https://github.com/STAT545-UBC-students/hw08-rasiimwe/blob/master/README.md)|This readme.md file provides an overview of the ghist of this repo and provides useful pointers to key files in my homework-8 repo. Herein, are also links to past files that provide an introduction to data exploration and analysis |
|**[Link to the Shiny app](https://explom.shinyapps.io/BCL-app/)**|This is the link to the developed Shiny app which is the main deliverable of this assignment. The app is deployed online on [shinyapps.io](http://www.shinyapps.io)|
|[app.R](https://github.com/STAT545-UBC-students/hw08-rasiimwe/blob/master/app/app.R)|This file contains the **source code** for the developed shiny app|

### Sources to acknowledge:
[STAT 547M class notes on Shiny](http://stat545.com/Classroom/notes/cm107.nb.html)
[Dean Attalis’s tutorial on building Shiny apps](https://deanattali.com/blog/building-shiny-apps-tutorial)
[Rstudio's documentation on Shiny dashboards](https://rstudio.github.io/shinydashboard/index.html)

