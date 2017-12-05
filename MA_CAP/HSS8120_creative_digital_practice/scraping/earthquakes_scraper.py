#now there's an rss feed :*() http://quakes.bgs.ac.uk/feeds/MhSeismology.xml
#lets import the libraries
from bs4 import BeautifulSoup
import urllib2

#fetch the raw html
page = urllib2.urlopen('http://www.earthquakes.bgs.ac.uk/earthquakes/recent_world_events.html').read()

#convert that page in to a recognised set of DOM objects (what's the DOM)
soup = BeautifulSoup(page,"html.parser")

#decide on a sensible file name
filename = "earthquakes.txt"
target = open(filename, 'w')

#find the bit of the page we are looking for using the css selector for class (what are selectors?)
table = soup.html.body.find_all('table', class_="bodyTable")

#it returns a list - find all the table rows in the first thing in this list
rows = table[0].find_all('tr')

#for each row in our link
for row in rows:

	cells = row.find_all('td')
	numCells = len(cells)
	if numCells==9:
		#annoyingly the first cell has weird formatting because it's a link
		date = cells[0].find('a').string
		time = cells[1].string
		lat = cells[2].string
		lon = cells[3].string
		depth = cells[4].string
		mag = cells[5].string
		region = cells[7].string
		print date, time, lat, lon,depth,mag,region,"\n"
		line = date+","+time+","+lat+","+lon+","+depth+","+mag+","+region+"\n"
		target.write(line)

target.close()
