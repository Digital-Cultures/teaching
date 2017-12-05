
from tweepy.streaming import StreamListener
from tweepy import OAuthHandler
from tweepy import Stream
import serial
import json
import atexit

# Go to http://apps.twitter.com and create an app.
# The consumer key and secret will be generated for you after
consumer_key="x"
consumer_secret="x"

# After the step above, you will be redirected to your app's page.
# Create an access token under the the "Your access token" section
access_token="4004246320-x"
access_token_secret="x"



class StdOutListener(StreamListener):
    """ A listener handles tweets are the received from the stream.
    This is a basic listener that just prints received tweets to stdout.
    """
    def on_data(self, data):
        
        decoded = json.loads(data)
        tweet_text = decoded['text'] #keys()
        #print decoded.keys()
        words = tweet_text.split(" ")
        for word in words:
            #print word
            if word == "#panamapapers":
                print tweet_text
                
        return True

    def on_error(self, status):
        print(status)

if __name__ == '__main__':
    l = StdOutListener()
    auth = OAuthHandler(consumer_key, consumer_secret)
    auth.set_access_token(access_token, access_token_secret)

    stream = Stream(auth, l)
    stream.filter(track=['zhe me diao'])
