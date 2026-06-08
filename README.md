# NDR-Sentiment-Analysis
This project aims to conduct linguistic analysis on Singaporean Prime Minister Lee Hsien Loong's National Day Rally speeches between 2004 and 2023.

## Step 1: Web Scraping
I used beautifulsoup to scrape the text of each rally. I recognise that I could have used R to do it, but I decided to use Python and beautifulsoup as I am more familiar with Python. For more details, please look through the Python file.

## Step 2: Text Processing
Following this tutorial (https://programminghistorian.org/en/lessons/basic-text-processing-in-r), I then performed text analysis on the corpus of rallies. This included plotting the change in word count and median sentence length over the years, as well as the most commonly used words in each rally.

### Observations
There is a continuous decreasing trend in word count over the years. This trend appears to be independent of any external events (e.g. the 2008 Global Financial Crisis, the 2011 General Elections, the COVID-19 pandemic). There does not appear to be any discernible trend in median sentence length over the years. 

There does not appear to be any discernible pattern or trend in the most common words used. This could indicate a lack of a consistent throughline in PM Lee's governance, although more data and research are needed to make this assertion. Additionally, the tokeniser did not accurately tokenise personal names. For example, "chok" and "tong" were the second and third most commonly used words in the 2004 speech. As PM Lee had just taken over from PM Goh Chok Tong in the previous year, his speech made several references to his predecessor, thus explaining how "chok" and "tong" made it on the list. However, the tokeniser failed to recognise them as a single entity. Similar instances occurred in the data, thus affecting the accuracy of this analysis.

## Step 3: Sentiment Analysis
Following this tutorial (https://programminghistorian.org/en/lessons/sentiment-analysis-syuzhet), I used syuzhet to perform sentiment analysis on the 2007 and 2008 rallies and the sentiment dataset used was the NRC Emotion Lexicon. This entailed plotting the distribution of emotions in each speech, creating a word cloud corresponding to various emotions and creating plots showing the change in sentiment over the speeches. The two rallies were chosen to compare differences in sentiment between a "normal" year (2007) and a "crisis" year (2008).

### Observations
The overall distribution of emotions between 2007 and 2008 was relatively similar. Negative emotions such as anger and fear were slightly higher in 2008 than in 2007, while positive emotions such as anticipation and trust were slightly lower. While this difference can definitely be attributed to the malaise surrounding the 2008 Global Financial Crisis, it also shows that the crisis did not significantly alter the emotional content of the rally speech, which continued to follow the emotional formula of previous years.

Comparing the sentiment progression of the two speeches, the 2007 National Day Rally began positively and became increasingly negative before ending on a positive note. Meanwhile, the 2008 National Day Rally began negatively and became positive before becoming increasingly negative. However, it also ended on a positive note. While the beginning of the two speeches differed significantly, likely due to the external circumstances surrounding the 2008 speech, there is also significant overlap in the sentiment progression of the two speeches from around the halfway mark onwards, which likewise suggests that National Day Rallies tend to follow an emotional formula in spite of external crises. However, more analysis (e.g. comparing a pre- and post-COVID-19 speech) should be done to support this assertion.
