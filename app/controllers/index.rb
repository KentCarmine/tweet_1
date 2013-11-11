# Display a form to allow user to enter the twitter handle of the user to get tweets from
get '/' do
  erb :index
end

# Get the username the user entered and the last 10 tweets from that user
post '/' do
  twitter_handle = params[:twitter_username]
  user = TwitterUser.find_or_create_by_name(:name => twitter_handle)

  users_tweets = Twitter.user_timeline(twitter_handle)[0..9]

  # tweet_text = []

  users_tweets.each do |tweet|
    # tweet_text << tweet[:attrs][:text]
    user.tweets.find_or_create_by_tweet_created_at(:text => tweet[:attrs][:text], :tweet_created_at => tweet[:attrs][:created_at])
    # puts tweet[:attrs][:text]
    # puts
  end


   redirect to "/#{twitter_handle}"
end

# Display last 10 tweets of username
get '/:username' do
  @user = TwitterUser.find_by_name(params[:username])
  @tweets = @user.tweets.limit(10)

  erb :show_tweets
end