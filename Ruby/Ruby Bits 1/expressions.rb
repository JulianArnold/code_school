# Expressions - Reps: 5

# unless
if ! tweets.empty?
  puts "Timeline:"
  puts tweets
end
# this reads better:
unless tweets.empty?
  puts "Timeline:"
  puts tweets
end

# unless with else
unless tweets.empty?
  puts "Timeline:"
  puts tweets
else
  puts 'No tweets were found!  Better follow some people!'
end
# unless with else is confusing so...
if tweets.empty?
  puts 'No tweets were found!  Better follow some people!'
else
  puts "Timeline:"
  puts tweets
end

# nil is falsey
if attachment.file_path != nil # just remove the conditional as it will return as true anyway
  attachment.post
end
if attachment.file_path
  attachment.post
end

# inline conditionals; instead of this...
if password.length < 8
  fail "Password too short"
end
unless username
  fail "No user name set"
end

# ...put this...
fail "Password too short" if password.length < 8
fail "No user name set" unless username

# short circuit and (&&)
if user
  if user.signed_in?
    #...
  end
end
# instead..
if user && user.signed_in?
  #..
end

# short circuit assignment
result = nil || 1 # 1
result = 1 || nil # 1
result = 1 || 2 # 1

# default values - "OR"
tweets = timeline.tweets
tweets = [] unless tweets
# if nil, default to an empty array
tweets = timeline.tweets || []

# short-circuit evaluation
def sign_in
  current_session || sign_user_in
end

# conditional assignment
i_was_set = 1
i_was_set ||= 2

i_was_not_set ||= 2
puts i_was_not_set # returns 2 because a nil value preceded the assignment of the '2'

options[:country] = 'us' if options[:country].nil?
options[:privacy] = true if options[:privacy].nil?
options[:geotag] = true if options[:geotag].nil?

options[:country] ||= 'us'
options[:privacy] ||= true
options[:geotag] ||= true

# conditional return values
if list_name
  options[:path] = "/#{user_name}/#{list_name}"
else
  options[:path] = "/#{user_name}"
end
# assign the value of the if statement
options[:path] = if list_name
                   "/#{user_name}/#{list_name}"
                 else
                   "/#{user_name}"
                 end

# more on conditional return values
def list_url(user_name, list_name)
  if list_name
    url = "https://twitter.com/#{user_name}/#{list_name}"
  else
    url = "https://twitter.com/#{user_name}"
  end
  url
end
# remove the url variable as the if statement returns a value...
def list_url(user_name, list_name)
  if list_name
    "https://twitter.com/#{user_name}/#{list_name}"
  else
    "https://twitter.com/#{user_name}"
  end
end

# case statement value
client_url = case client_name
               when "web"
                 "http://twitter.com"
               when "Facebook"
                 "http://www.facebook.com/twitter"
               else
                 nil
             end

# case - ranges
popularity = case tweet.retweet_count
               when 0..9
                 nil
               when 10..99
                 "trending"
               else
                 "hot"
             end

# case regexps
tweet_type = case tweet.status
               when /\A@\w+/
                 :mention
               when /\Ad\s+\w+/
                 :direct_message
               else
                 :public
             end
# as above with 'whens' and 'thens'
tweet_type = case tweet.status
               when /\A@\w+/          then  :mention
               when /\Ad\s+\w+/       then  :direct_message
                 else                       :public
             end