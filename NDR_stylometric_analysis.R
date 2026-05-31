if (!require("pacman")) install.packages("pacman")

pacman::p_load(pacman, tidyverse, magrittr, ggplot2, readr, tokenizers)

files_loc <- "/Users/hhshe/OneDrive/Documents/Desktop/NDR"

files <- dir(files_loc, full.names = TRUE)
text <- c()
for (f in files) {
  text <- c(text, paste(readLines(f, warn = FALSE), collapse = "\n"))
}

years <- c(2004:2019, 2021:2023)

text %<>% as_tibble(.name_repair = "unique") %>%
  mutate(year = years)

#Counts the number of words for each speech
words <- tokenize_words(text$value)

words_plot <- text %>%
  ggplot(aes(x = year, y = sapply(words, length))) +
  geom_point()

words_plot

#Counts median sentence length for each speech
sentences <- tokenize_sentences(text$value)
sentence_words <- sapply(sentences, tokenize_words)

sentence_length <- list()
for (i in 1:nrow(text)) {
  sentence_length[[i]] <- sapply(sentence_words[[i]], length)
}

sentence_length_median <- sapply(sentence_length, median)

sentences_plot <- text %>%
  ggplot(aes(x = year, y = sentence_length_median)) +
  geom_point()

sentences_plot  

#Finds the most common words used in each speech

#Uses an online corpus of words to exclude commonly-used words
base_url <- "https://raw.githubusercontent.com/programminghistorian/jekyll/gh-pages/assets/basic-text-processing-in-r/"
wf <- read_csv(sprintf("%s/%s", base_url, "word_frequency.csv"))

description <- c()
for (i in 1:length(words)) {
  tab <- table(words[[i]])
  tab <- data_frame(word = names(tab), count = as.numeric(tab))
  tab <- arrange(tab, desc(count))
  tab <- inner_join(tab, wf)
  tab <- filter(tab, frequency < 0.002 & word != "singaporeans" & word != "singaporean") #"Singaporean(s)" is the most common word in most speeches, which isn't useful analysis
  
  result <- c(text$year[i], tab$word[1:5])
  description <- c(description, paste(result, collapse = "; "))
}

cat(description, sep = "\n")
