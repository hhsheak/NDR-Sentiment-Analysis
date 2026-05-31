import urllib.request, urllib.error, urllib.parse
import time
import random
from bs4 import BeautifulSoup

ndr_urls = [] #Stores the URLs for each National Day Rally
file_names = [] #Stores the names to be used when creating the files
years_list = [] #Stores the years, to be used when identifying the video HTML attribute

year = 2004
while year <= 2023:
  if year == 2020: #2020 had no National Day Rally, so this section skips over the year
    pass
  else:
    if year <= 2019 or year == 2023:
      url = "https://www.pmo.gov.sg/newsroom/national-day-rally-" + str(year)
      ndr_urls.append(url)
    else: #2021 and 2022 had a different URL convention, so this section accounts for that
      url = "https://www.pmo.gov.sg/newsroom/national-day-rally-" + str(year) + "-english"
      ndr_urls.append(url)
    file_names.append(f"{year}.txt")
    years_list.append(year)
  year += 1

for file_name, url, year in zip(file_names, ndr_urls, years_list):
  response = urllib.request.urlopen(url)
  webContent = response.read().decode("UTF-8")
  soup = BeautifulSoup(webContent, "html.parser")

  video = soup.find("button", attrs={"aria-label": f'Play National Day Rally {year}'}) #For each webpage, the main text begins after the video of the corresponding rally, so this line identifies the video

  f = open(file_name, "w")

  for para in video.find_all_next(string=True): #Writes the main text (which will be after the video) into the corresponding file
    f.write(para.text)

  f.close()

  time.sleep(random.randint(0,3)) #Avoid overwhelming the website / being identified as a bot