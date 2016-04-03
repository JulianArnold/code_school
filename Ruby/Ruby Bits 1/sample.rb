# methods and classes
# reps: 2

# optional arguments
def tweet(message, lat, long)
  # ..
end
tweet("Practicing Ruby-Fu", nil, nil)
# location isn't always used so let's add defaults..

def tweet(message, lat = nil, long = nil, reply_id = nil)
  # .. long parameter list
end
tweet("Practicing Ruby-Fu!", 28.55, -81.33, 227946)
# calls to the above are hard to read
tweet("Practicing Ruby-Fu", nil, nil, 227946)
# hard to keep placeholders for

# one way to solve this is an 'option hash' which will replace an excessive, hard to read set of parameters

# hash arguments
def tweet(message, options = {})
  status = Status.new
  status.lat = options[:lat]
  status.long = options[:long]
  status.body = messages
  status.reply_id = options[:reply_id]
  status.post
end

tweet("Practicing Ruby-Fu!",
  :lat => 29.55,
  :long => -81.33,
  :reply_id => 227946
) # keys show meaning

# named srguments - hash using Ruby 1.9:
tweet("Practicing Ruby-Fu!",
  lat: 28.55
  long: -81.33,
  reply_d: 227946
)

# we can also re-position the keys as we like:
tweet("Practicing Ruby-Fu!",
      reply_d: 227946,
      lat: 28.55,
      long: -81.33
)
# keys are optional and we can also omit the option hash and the method still works

# if there are no tweets at all, would your code throw an error?  not if you use exceptions:
def get_tweets(list)
  if list.authorized?(@user)
    list.tweets
  else
    [] # "magic" return value
  end
end
tweets = get_tweets(my_list)
if tweets.empty?
  alert "No tweets found." + "Are you authorized to acces this list?"
end

# exceptions
def get_tweets(list)
  unless list.authorized?(@user)
    raise AuthorizedException.new
  end
  list.tweets
end
# raise an exception instead

begin
  tweets = get_tweets(my_list)
rescue AuthorizationException
  warn "You are not authorised to access this list."
end
# caller KNOWS there's a problem

# "splat" arguments where '*' star means there's an array being passed in..
def mention(status, *names)
  tweet("#{names.join(' ')} #{status}")
end
mention('Your courses rocked!', 'eallam', 'greggpollack', 'jasonvanlue')

# CLASSES

user_names = [
    ["Ashton", "Kutcher"],
    ["Wil", "Wheaton"],
    ["Madge"]
]
user_names.each { |n| puts "#{n[1]}, #{n[0]}" }
# output reads like...
# Kutcher, Ashton
# Wheaton, Wil
# Madge

# you need a class when...
class Name
  def initialize(first, last = nil)
    @first = first
    @last = last
  end
  def format
    [@last, @first].compact.join(', ')
  end
end

# results..
user_names = []
user_names << Name.new('Ashton', 'Kutcher')
user_names << Name.new('Wheaton', 'Wil')
user_names << Name.new('Madge')
user_names.each { |n| puts n.format }

# output is properly formatted then without any blank spaces or oddly placed commas

# oversharing?
class Tweet
  attr_accessor :status
  attr_reader :created_at # creates a getter function only
  def initialize(status)
    @status = status
    @created_at = Time.new
  end
end
tweet = Tweet.new("Eating Breakfast.")
tweet.created_at = Time.new(2084, 1, 1, 0, 0, 0, "-07:00")

attr_accessor :baz # is a getter and setter method that is this...

def baz=(value)
  @baz = value
end
def baz
  @baz
end

# re-opening classes
tweet = Tweet.new("Easting Lunch.")
puts tweet.to_s # not so readable result

#re-open class and re-define it..
class Tweet
  def to_s
    "#{@status}\n#{@created_at}"
  end
end
tweet = Tweet.new("Eating lunch.")
puts tweet.to_s # Eating lunch.  2012-08-02...

# self
class UserList
attr_accessor :name
def initialize(name)
  name = name # just re-sets the local variable to 'name'
end
end
list.UserList.new('celebrities')
list.name # result is 'nil'

class UserList
  attr_accessor :name
  def initialize(name)
    self.name = name # this calls "name=" on the current object
  end
end
list.UserList.new('celebrities')
list.name # result is 'celebrities'

# END