# NDR-Sentiment-Analysis
This project aims to conduct linguistic analysis on Singaporean Prime Minister Lee Hsien Loong's National Day Rally speeches between 2004 and 2023.

## Step 1: Web Scraping
I used beautifulsoup to scrape the text of each rally. I recognise that I could have used R to do it, but I decided to use Python and beautifulsoup as I am more familiar with Python. For more details, please look through the Python file.

## Step 2: Text Processing
Following this tutorial (https://programminghistorian.org/en/lessons/basic-text-processing-in-r), I then performed text analysis on the corpus of rallies. This included plotting the change in median sentence length over the years, as well as the most commonly used words in each rally.

## Step 3: Sentiment Analysis
Following this tutorial (https://programminghistorian.org/en/lessons/sentiment-analysis-syuzhet), I used syuzhet to perform sentiment analysis on the 2007 and 2008 rallies. The two rallies were chosen to compare the differences in sentiment between a "normal" year (2007) and a "crisis" year (2008).
