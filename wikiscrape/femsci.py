import wikipedia
import requests
from bs4 import BeautifulSoup
import time
import numpy as np
import csv
import wptools
import pandas as pd

html1 = requests.get('https://en.wikipedia.org/wiki/Category:American_women_scientists')
html2 = requests.get('https://en.wikipedia.org/w/index.php?title=Category:American_women_scientists&pagefrom=Ellis%2C+Charlotte+Cortlandt%0ACharlotte+Cortlandt+Ellis#mw-pages')
html3 = requests.get('https://en.wikipedia.org/w/index.php?title=Category:American_women_scientists&pagefrom=Lee%2C+Julia+Southard%0AJulia+Southard+Lee#mw-pages')
html4 = requests.get('https://en.wikipedia.org/w/index.php?title=Category:American_women_scientists&pagefrom=Salmeen%2C+Annette%0AAnnette+Salmeen#mw-pages')

b1 = BeautifulSoup(html1.text, 'lxml')
b2 = BeautifulSoup(html2.text, 'lxml')
b3 = BeautifulSoup(html3.text, 'lxml')
b4 = BeautifulSoup(html4.text, 'lxml')

b = [b1,b2,b3,b4]

links = []

for x in b:
    for i in x.find_all():
        # pull the actual link for each one
        for link in i.find_all('a', href=True):
            links.append(link['href'])

people_links = []
for link in links:
    if link.startswith("/wiki/"):
        people_links.append(link)

stopwords = "Portal","Category","Wikipedia","Special","Help","file","Main_Page","File","Women"

cleanedLinks = []

for links in people_links:
    if any(substring in links for substring in stopwords)== False:
        cleanedLinks.append(links)

names = []
for links in cleanedLinks:
    if any(char.isdigit() for char in links) == False:
        names.append(links.rsplit('/', 1)[-1])

names = list(set(names))

infobox = []
not_found = []
noinfobox = []
for name in names:
    try:
        temp = wptools.page(name).get_parse().data
        temp = temp['infobox']
        if temp != None:
            infobox.append(temp)
        else:
            noinfobox.append(name)
    except:
        print('Author not found')
        not_found.append(name)

infobox_table = pd.DataFrame(infobox)


with open('noinfobox.csv', 'w') as f:
    writer = csv.writer(f)
    for val in noinfobox:
        writer.writerow([val])

with open('not_found.csv', 'w') as f:
    writer = csv.writer(f)
    for val in not_found:
        writer.writerow([val])

infobox_table.to_csv('infobox.csv',sep='|')
