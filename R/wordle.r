#!/usr/bin/env Rscript
# Functions of the game


#' @export
wordle = function(){
  load(file = "R/sysdata.rda")
  secret <- sample(words[, 1], 1)
  canvas <- data.frame()

  # Check Input
  isCorrect = function(userInput, secret){

    userInput <- strsplit(userInput, "")[[1]]
    secret <- strsplit(secret, "")[[1]]

    correct <- rep(0, 5)

    for(i in 1:5){
      if(secret[i] == userInput[i]){
        correct[i] <- 1
      }
    }

    return(correct)
  }

  isPresent = function(userInput, secret){

    userInput <- strsplit(userInput, "")[[1]]
    secret <- strsplit(secret, "")[[1]]

    present <- rep(0, 5)

    for(i in 1:5){
      if(is.element(userInput[i], secret)){
        present[i] <- 1
      }
    }
    return(present)
  }

  for(i in 1:6){

    userInput <- readline(prompt = "Enter a word: ")

#    if(userInput == ""){
#
#      userInput <- "error"
#    }

    if(nchar(userInput) != 5){

      warning("The word should only contain five letters")
      userInput <- readline(prompt = "Enter a word: ")

    } else if(identical(userInput, secret)){

      canvas[i, 1:5] <- strsplit(userInput, "")[[1]]
      colnames(canvas) <- c("1", "2", "3", "4", "5")
      cat("Congrats!!! You have found the secret word \n")
      break
    } else {

      correct <- isCorrect(userInput, secret)
      present <- isPresent(userInput, secret)
      canvas[i, 1:5] <- strsplit(userInput, "")[[1]]
      colnames(canvas) <- c("1", "2", "3", "4", "5")
    }

      print(canvas[1:i, ])
      cat("Correct: ", correct, "\n")
      cat("Present: ", present, "\n")

      if(i == 6){
        print(canvas)
        cat("Better luck next time! \n")
        cat("The solution was", secret, "\n")
      }

  }
}
