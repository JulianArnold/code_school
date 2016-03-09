# Expressions - Reps: 4

# unless vs. if

if ! tweets.empty?
  puts "Timeline:"
  puts tweets
end

unless tweets.empty?
  puts "Timeline:"
  puts tweets
end

# unless with else
unless tweets.empty?
  puts "Timeline:"
  puts tweets
else
  puts "No tweets found - better follow some people!"
end

if tweets.empty?
  puts "No tweets found - better follow some people!"
else
  puts "Timeline:"
  puts tweets
end

# nil is false-y
if attachment.file_path != nil
  attachment.post
end

if attachment.file_path
  attachment.post
end

# only nil is false-y
unless name.length
  warn "User name required"
end

# inline conditionals a way to 'de-block' code and put it into 1 line..
if password.length < 8
  fail "Password too short"
end
unless username
  fail "No user name set"
end
#.. so it looks like this..
fail "Password too short" if password.length < 8
fail "No user name set" unless username

# short-circuit AND "&&"
if user
  if user.signed_in?
    #..
  end
end
# the short..
if user && user.signed_in?
  #..
end

# short circuit assignment (all result in '1' or a boolean true value)
result = nil || 1
result = 1 || nil
result = 1 || 2

# default values  - "OR"
tweets = timeline.tweets
tweets = [] unless tweets

tweets = timeline.tweets || []

# short circuit evaluation
def sign_in
  current_session || sign_user_in
end

# conditional assignment
i_was_set = 1
i_was_set ||= 2 # only assigns a new value if there's none already present

puts i_was_set

i_was_not_set ||= 2

puts i_was_not_set

options[:country] = 'us' if options[:country].nil?
options[:privacy] = true if options[:privacy].nil?
options[:geotag] = true if options[:geotag].nil?

options[:country] ||= 'us'
options[:privacy] ||= true
options[:geotag] ||= true

if list_name
  options[:path] = "/#{user_name}/#{list_name}"
else
  options[:path] = "/#{user_name}"
end

options[:path] = if list_name
                   "/#{user_name}/#{list_name}"
                 else
                   "/#{user_name}"
                 end

def list_url(user_name, list_name)
  if list_name
    "https://twitter.com/#{user_name}/#{list_name}"
  else
    "https://twitter.com/#{user_name}"
  end
end

client_url = case client_name
               when "web"
                 "http://twitter.com"
               when "Facebook"
                 "http://www.facebook.com/twitter"
               else
                 nil
             end

tweet_type = case tweet.status
               when /\A@\w+/        then  :mention
               when /\Ad\s+\w+/     then  :direct_message
               else                       :public
             end