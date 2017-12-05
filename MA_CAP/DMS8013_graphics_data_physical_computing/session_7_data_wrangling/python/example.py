from __future__ import absolute_import, print_function

from tweepy.streaming import StreamListener
from tweepy import OAuthHandler
from tweepy import Stream


import json

# Go to http://apps.twitter.com and create an app.
# The consumer key and secret will be generated for you after
consumer_key="z"
consumer_secret="z"

# After the step above, you will be redirected to your app's page.
# Create an access token under the the "Your access token" section
access_token="x-z"
access_token_secret="z"

class StdOutListener(StreamListener):
    """ A listener handles tweets that are received from the stream.
    This is a basic listener that just prints received tweets to stdout.
    """
    def on_data(self, data):
        print(data)
        decoded = json.loads(data)

        print type(decoded)
        # tweet_text = decoded['text'] #keys()
        # words = tweet_text.split(" ")

        return True

    def on_error(self, status):
        print(status)

if __name__ == '__main__':
    l = StdOutListener()
    auth = OAuthHandler(consumer_key, consumer_secret)
    auth.set_access_token(access_token, access_token_secret)

    stream = Stream(auth, l)
    stream.filter(track=['poststructuralism'])