#!/usr/bin/env Rscript
# Functions of the game


#' @export
wordle <- function() {
  cat("\n")
  cat("  _/          _/    _/_/    _/_/_/    _/_/_/    _/        _/_/_/_/
 _/          _/  _/    _/  _/    _/  _/    _/  _/        _/
_/    _/    _/  _/    _/  _/_/_/    _/    _/  _/        _/_/_/
 _/  _/  _/    _/    _/  _/    _/  _/    _/  _/        _/
  _/  _/        _/_/    _/    _/  _/_/_/    _/_/_/_/  _/_/_/_/   \n")
  cat("\n")
  cat("\n")
  cat("Enjoy the Wordle game in the Command line!\n")
  cat("Options: \n")
  cat(".play          To play the game \n")
  cat(".info          To see the rules of the game \n")
  cat(".exit          To get exit the game \n")
  cat("\n")

  readline(prompt = "Press [enter] to continue")
  option <- readline(prompt = "> ")

  if (option == ".play") {
    play()
  } else if (option == ".info") {
    info()
  } else if (option == ".exit") {
    q()
  } else {
    stop("Error! '", option, "' is not recognized")
    wordle()
  }
}

newGame <- function() {
  Sys.setenv(LANG = "en")
  rm(list = ls())

  dict <- load("data/words.csv")
  chosen <<- sample(subset(dict[, 1], dict[, 2] == 1), 1)
  attempts <<- data.frame()
}


cleanSetup <- function() {
  correct <<- rep(0, 5)
  present <<- rep(0, 5)
  isFound <<- rep(1, 5)
  success <<- FALSE
}

check <- function() {
  solution <- strsplit(chosen, "")
  attempt <- strsplit(userInput, "")

  for (i in 1:5) {
    if (isTRUE(solution[[1]][i] == attempt[[1]][i])) {
      correct[i] <<- 1
      isFound[i] <<- attempt[[1]][i]
    } else {
      correct[i] <<- 0
    }

    if (is.element(attempt[[1]][i], solution[[1]])) {
      present[i] <<- 1
    } else {
      present[i] <<- 0
    }
  }
}

Game <- function() {
  for (trial in 1:6) {
    userInput <<- readline(prompt = "Enter a word: ")

    if (nchar(userInput) != 5) {
      warning("The word should only contain five letters")
      Game()
    } else if (identical(userInput, chosen)) {
      attempt <- strsplit(userInput, "")
      attempts[trial, 1:5] <<- attempt[[1]]
      cat("Congrats! You found the secret word '", chosen, "'\n")
      success <<- TRUE
      break
    } else {
      check()
      attempt <- strsplit(userInput, "")
      attempts[trial, 1:5] <<- attempt[[1]]
    }

    print(attempts[1:trial, ])
    cat("Correct: ", correct, "\n")
    cat("Present: ", present, "\n")

    if (trial == 6) {
      print(attempts)
      cat("Better luck next time! \n")
      cat("The solution was", chosen, "\n")
    }
  }

  wordle()
}

play <- function() {
  newGame()
  cleanSetup()
  Game()
}

info <- function() {
  text <- readr::read_file("text/info.txt")
  cat(text, "\n")

  # Go back to home
  readline(prompt = "Press [enter] to continue")
  wordle()
}


