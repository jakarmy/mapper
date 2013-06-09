import urllib, json
import pprint


URL = "https://api.foursquare.com/v2/venues/explore?"
client_id = "client_id=NUIXQFWVPJ4023CJ24WUVF5SDC0NQVYUF3XXPA4WYZDSIWBL"
client_secret = "client_secret=DEKNC3QK00BHHSKYMESAM4PRAT2DGPGNQ4ETPYNPF1PDDLNH"
v = "v=20130602"
radius = "radius="
ll1 = "ll="

max_latitude = -16
min_latitude = -55
# -180-180

max_longitude = -66
min_longitude = -76
# -90-90

step = 1

current_latitude = min_latitude
current_longitude = min_longitude

ll = ll1+str(current_latitude)+","+str(current_longitude)
radius1 = radius+"110000"
f1=open('./datafile.rb', 'w+')

while current_longitude <= max_longitude:
	current_latitude = min_latitude
	while current_latitude <= max_latitude:

		#add code here#########################################
		print (URL + client_id +"&"+ client_secret +"&" +v+"&"+radius1+"&"+ ll)
		four_response = urllib.urlopen(URL + client_id +"&"+ client_secret +"&" +v+"&"+radius1+"&"+ ll)
		jsonResponse = json.loads(four_response.read())
		if jsonResponse.has_key('numResults'):
			if int(jsonResponse['numResults'])>0:
				for group in jsonResponse['response']['groups']:
					for item in group['items']:
						try:
							name = item['venue']['name'].encode('utf8')
							address = item['venue']['location']['address'].encode('utf8')
							f1.write( 'Place.create(name: "'+name+'", address: "'+address+'", longitude: "'+str(float(item['venue']['location']['lng']))+'", latitude: "'+str(float(item['venue']['location']['lat']))+'")\n')
						except KeyError:
							name = item['venue']['name'].encode('utf8')
							f1.write( 'Place.create(name: "'+name+'", longitude: "'+str(float(item['venue']['location']['lng']))+'", latitude: "'+str(float(item['venue']['location']['lat']))+'")\n')
						
			#######################################################
		current_latitude = current_latitude+step
		ll = ll1+str(current_latitude)+","+str(current_longitude)
	current_longitude = current_longitude+step
	ll = ll1+str(current_latitude)+","+str(current_longitude)