
from tweepy.streaming import StreamListener
from tweepy import OAuthHandler
from tweepy import Stream
import serial
import json
import atexit


#ser = serial.Serial('/dev/cu.usbmodem1421', 9600)

# # Go to http://apps.twitter.com and create an app.
# # The consumer key and secret will be generated for you after
consumer_key="z"
consumer_secret="x"

# After the step above, you will be redirected to your app's page.
# Create an access token under the the "Your access token" section
access_token="-x"
access_token_secret="x"

# consumer_key="bGGszI9iMghvqaPPUCL73FKAv"
# consumer_secret="jPoNLksay5Kj4D1Oa2V5PWYb1oGFiOPVfiK8IgC6fZLBpwO2Wl"
# access_token = "2449845318-cczxTqYgftD6gT7lW8jkKQSyFXQRjJERfSqdSnN"
# access_token_secret = "m67CGNJleHLvarP9HQlynoOWRfVVL43DnbXx8EFT9LIza" 

def exit_handler():
    print "exit"

class StdOutListener(StreamListener):
    """ A listener handles tweets are the received from the stream.
    This is a basic listener that just prints received tweets to stdout.
    """
    def on_data(self, data):
        
        decoded = json.loads(data)
        tweet_text = decoded['text'] #keys()
        words = tweet_text.split(" ")
        for word in words:
            #print word
            if word == "#panamapapers":
                print tweet_text
                #ser.write('5\n')

        #json.dumps(decoded['text'])
        #pp.pprint(data)
        #print data._json['text']
        return True

    def on_error(self, status):
        print(status)

if __name__ == '__main__':
    atexit.register(exit_handler)
    l = StdOutListener()
    auth = OAuthHandler(consumer_key, consumer_secret)
    auth.set_access_token(access_token, access_token_secret)

    stream = Stream(auth, l)
    stream.filter(track=['cameron'])