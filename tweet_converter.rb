class TweetConverter
  attr_reader :tweet

  def initialize(tweet)
    @tweet = tweet
  end

  def has_media?
    @tweet.media?
  end

  def retweeted?
    @tweet.retweeted_tweet?
  end

  def retweet_count
    @tweet.retweet_count
  end

  def hashtags?
    @tweet.hashtags?
  end

  def has_hashtag?(target)
    @tweet.hashtags.any? { |hashtag| hashtag.text == target }
  end

  def media_type
    @media_item.type             #returns type of media for example "photo"
  end

  def get_media
    @tweet.media                 #returns an array of media photos
  end
end
