class TwitterUser < ActiveRecord::Base
  # Remember to create a migration!
  has_many :tweets

  def get_recent_tweets
     self.tweets.order('tweet_created_at DESC').limit(10)
  end

  def tweets_stale?
    return true if self.tweets.empty?

    Time.now - self.updated_at > (15*60) # older than 15 mins
  end
end
