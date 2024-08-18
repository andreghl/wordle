# Wordle in the R Console

I created this project to learn how to create a package in R. I do not aim to provide a new functionality to R *(it is quite easy to find other similar projects on Github)*. If you wish to install this package on your device, run:

```r
# install.packages("devtools") 
library(devtools)

install_github("andregl/wordle")
```

Once the package is loaded, the game can be played by running ```wordle()```. In the terminal, the game looks as follows:

<div style = "width: 70%; text-align: center; margin: auto;">

![Example](img/game.png)

</div>

For each attempt, the output is kept at a minimum, only presenting the necessary information. Also, the program does not check whether the attempted word is within the list of available words. This task is left to the player.