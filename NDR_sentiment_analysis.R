if (!require("pacman")) install.packages("pacman")

pacman::p_load(pacman, tidyverse, magrittr, ggplot2)
pacman::p_load(syuzhet, RColorBrewer, wordcloud, tm, patchwork, scales)

files <- c("/Users/hhshe/OneDrive/Documents/Desktop/NDR/2007.txt", "/Users/hhshe/OneDrive/Documents/Desktop/NDR/2008.txt")
text <- c()
for (f in files) {
  text <- c(text, paste(readLines(f, warn = FALSE), collapse = "\n"))
} #Copies the text of each rally into a vector

text_word_2007 <- get_tokens(text[1])
sentiment_2007 <- get_nrc_sentiment(text_word_2007, lang = "english") #Tokenises the texts and performs sentiment analysis on them

text_word_2008 <- get_tokens(text[2])
sentiment_2008 <- get_nrc_sentiment(text_word_2008, lang = "english")

#Plots bar charts showing the frequency of each emotion
ndr_emotions_values_2007 <- prop.table(sentiment_2007[,1:8]) %>%
  as_tibble() %>%
  summarise_all(sum) %>%
  pivot_longer(
    cols = everything(),
    names_to = "emotion",
    values_to = "value"
  )

ndr_emotions_values_2008 <- prop.table(sentiment_2008[,1:8]) %>%
  as_tibble() %>%
  summarise_all(sum) %>%
  pivot_longer(
    cols = everything(),
    names_to = "emotion",
    values_to = "value"
  )

ndr_emotions_2007 <- ndr_emotions_values_2007 %>% 
  ggplot(aes(x = emotion, y = value, fill = brewer.pal(n = 8, name = "Set3"))) + 
  geom_col() +
  scale_fill_discrete(labels = ndr_emotions_values_2007$emotion) +
  labs(x = "2007") +
  theme(legend.position = "bottom", legend.title = element_blank())

ndr_emotions_2008 <- ndr_emotions_values_2008 %>% 
  ggplot(aes(x = emotion, y = value, fill = brewer.pal(n = 8, name = "Set3"))) + 
  geom_col() +
  scale_fill_discrete(labels = ndr_emotions_values_2008$emotion) +
  labs(x = "2008") +
  theme(legend.position = "bottom", legend.title = element_blank())

(ndr_emotions_2007 / ndr_emotions_2008) + plot_layout(guides = "collect") + plot_annotation("Emotions")

#Creates word clouds that shows the most used words for each emotion
cloud_emotions_data_2007 <- c(
  paste(text_word_2007[sentiment_2007$anger> 0], collapse = " "),
  paste(text_word_2007[sentiment_2007$anticipation > 0], collapse = " "),
  paste(text_word_2007[sentiment_2007$disgust > 0], collapse = " "),
  paste(text_word_2007[sentiment_2007$fear > 0], collapse = " "),
  paste(text_word_2007[sentiment_2007$joy> 0], collapse = " "),
  paste(text_word_2007[sentiment_2007$sadness> 0], collapse = " "),
  paste(text_word_2007[sentiment_2007$surprise> 0], collapse = " "),
  paste(text_word_2007[sentiment_2007$trust> 0], collapse = " "))

cloud_emotions_data_2007 %<>% iconv("latin1", "UTF-8")

cloud_corpus_2007 <- Corpus(VectorSource(cloud_emotions_data_2007))

cloud_tdm_2007 <- cloud_corpus_2007 %>% 
  TermDocumentMatrix() %>%
  as.matrix()

colnames(cloud_tdm_2007) <- c('anger', 'anticipation', 'digust', 'fear', 'joy', 'sadness', 'surprise', 'trust')

set.seed(1)
comparison.cloud(cloud_tdm_2007, random.order = FALSE,
                 title.size = 0.5, max.words = 50, scale = c(1, 1), rot.per = 0.4)

cloud_emotions_data_2008 <- c(
  paste(text_word_2008[sentiment_2008$anger> 0], collapse = " "),
  paste(text_word_2008[sentiment_2008$anticipation > 0], collapse = " "),
  paste(text_word_2008[sentiment_2008$disgust > 0], collapse = " "),
  paste(text_word_2008[sentiment_2008$fear > 0], collapse = " "),
  paste(text_word_2008[sentiment_2008$joy> 0], collapse = " "),
  paste(text_word_2008[sentiment_2008$sadness> 0], collapse = " "),
  paste(text_word_2008[sentiment_2008$surprise> 0], collapse = " "),
  paste(text_word_2008[sentiment_2008$trust> 0], collapse = " "))

cloud_emotions_data_2008 %<>% iconv("latin1", "UTF-8")

cloud_corpus_2008 <- Corpus(VectorSource(cloud_emotions_data_2008))

cloud_tdm_2008 <- cloud_corpus_2008 %>% 
  TermDocumentMatrix() %>%
  as.matrix()

colnames(cloud_tdm_2008) <- c('anger', 'anticipation', 'digust', 'fear', 'joy', 'sadness', 'surprise', 'trust')

set.seed(1)
comparison.cloud(cloud_tdm_2008, random.order = FALSE,
                 title.size = 0.5, max.words = 50, scale = c(1, 1), rot.per = 0.4)

#Creates a graph that compares the progression of sentiment across the speeches
sentiment_valence_2007 <- (sentiment_2007$negative *-1) + sentiment_2007$positive

sentiment_valence_2007_transformed <- get_dct_transform(sentiment_valence_2007)

sentiment_time_2007 <- data.frame(
  valence = rescale(sentiment_valence_2007_transformed, to = c(-1, 1)),
  time = 1:length(sentiment_valence_2007_transformed)
)

sentiment_valence_2008 <- (sentiment_2008$negative *-1) + sentiment_2008$positive

sentiment_valence_2008_transformed <- get_dct_transform(sentiment_valence_2008)

sentiment_time_2008 <- data.frame(
  valence = rescale(sentiment_valence_2008_transformed, to = c(-1, 1)),
  time = 1:length(sentiment_valence_2008_transformed)
)

sentiment_plot <- ggplot() +
  geom_line(data = sentiment_time_2007, aes(x = time, y = valence, color = "2007")) +
  geom_line(data = sentiment_time_2008, aes(x = time, y = valence, color = "2008")) +
  scale_color_manual(values = c("2007" = "green", "2008" = "red")) +
  labs(color = "Year", y = "sentiment", title = "Sentiment over time")

sentiment_plot


