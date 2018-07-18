class TwitterPhotosTool
  attr_reader :photos, :tweets, :tweeter

  def initialize(tweeter_item)
    @tweeter = tweeter_item
  end

  def get_tweets(hashtag, args={})
    @tweets = @tweeter.search(hashtag, args)
  end

  def rank_tweets(tweets)
    tweets.sort_by { |tweet| tweet.retweet_count * -1 }
  end

  def filtered?(word, tweet)
    tweet.has_media? && tweet.hashtags? && tweet.has_hashtag?(word)
  end

  def is_type(item_type, media)
    media.any? { |media_item| media_item.type == item_type}
  end

  def display_photos(photos)
    photos.flatten.each {|photo| puts photo.media_url.to_s }
  end
end
