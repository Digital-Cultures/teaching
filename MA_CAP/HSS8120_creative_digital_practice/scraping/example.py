from bs4 import BeautifulSoup
import urllib2

print "hello python"

#fetch the raw html (this link is on the blog)
page = urllib2.urlopen('http://www.earthquakes.bgs.ac.uk/earthquakes/recent_world_events.html').read()

#convert that page in to a recognised set of DOM objects (what's the DOM)
soup = BeautifulSoup(page,"html.parser")


#this is where I'm getting all the stuff I'm actually interested in
table = soup.html.body.find_all('table', class_="bodyTable")

#it returns a list - find all the table rows in the first thing in this list
rows = table[0].find_all('tr')

#for each row in our link
for row in rows:
	print "/////////////////////// ***NEW ROW*** :) ////////////////////////"
	cells = row.find_all('td')

	#check the number of cells
	numCells = len(cells)
	#if there 9 then this is the right kind of thing
	if numCells==9:
		#lets check this is what we want
		time = cells[1].string
		region = cells[7].string
		print time, region


print "now this loop has finished"