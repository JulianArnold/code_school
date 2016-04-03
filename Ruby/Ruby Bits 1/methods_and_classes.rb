# METHODS

# optional arguments
# bad code:
def tweet(message, lat, long)
  #..
end
tweet("Practicing Ruby-Fu!", nil, nil)

#good code
def tweet(message, lat = nil, long = nil)
  #..
end
tweet("Practicing Ruby-Fu!")

# named arguments
def tweet(message, lat = nil, long = nil, reply_id = nil)
  #..
end
tweet("Practicing Ruby-Fu!", 28.55, -81.33, 227946)
tweet("Practicing Ruby-Fu!", nil, nil, 227946)

# solution?  an option hash, of course!
# hash arguments
def tweet(message, options = {})
  status = Status.new
  status.lat = options[:lat]
  status.long = options[:long]
  status.body = message
  status.reply_id = options[:reply_id]
  status.post
end

# the date to be passed in to the hash within the parameters
tweet("Practicing Ruby-Fu!",
      :lat => 28.55,
      :long => -81.33,
      :reply_id => 227946
)

# using the Ruby 1.9 hash syntax (note missing hash rocket):
tweet("Practicing Ruby-Fu!",
      lat: 28.55,
      long: -81.33,
      reply_id: 227946
)

# repositioning the keys:
tweet("Practicing Ruby-Fu!",
      reply_id: 227946,
      lat: 28.55,
      long: -81.33
)
# keys are optional:
tweet("Practicing Ruby-Fu!",
      reply_id: 227946
)

# complete hash is optional:
tweet("Practicing Ruby-Fu!")

# exceptions
def get_tweets(list)
  if list.authorized(@user)
    list.tweets
  else
    [] # "magic return value"
  end
end

tweets = get_tweets(my_list)
if tweets.empty?
  alert "No tweets were found!" + "Are you authorized to access this list?" # can't be sure it's an error
end

def get_tweets(list)
  unless list.authorised?(@user)
    raise AuthorisationException.new
  end
  list.tweets
end

begin
  tweets = get_tweets(my_list)
rescue AuthorisationException
  warn "You are not authorised to access this list."
end

# splat arguments (with an asterisk *)
def mention(status, *name)
  tweet("#{name.join('')} #{status}")
end
mention('Your courses rocked', 'eallam', 'gregpollack', 'jasonvalue')

# CLASSES

user_names = [
    ["Ashton", "Kutcher"],
    ["Will", "Wheaton"],
    ["Maddonna"]
]
user_names.each { |n| puts "#{n[1]}, #{n[0]}" }

class Name
  def initialize(first, last = nil)
    @first = first
    @last = last
  end
  def format
    [@last, @first].compact.join(', ')
  end
end

user_names = []
user_names << Name.new('Ashton', 'Kutcher')
user_names << Name.new('Wil', 'Wheaton')
user_names << Name.new('Madonna')
user_names.each { |n| puts n.format }

# output:
# Kutcher, Ashton
# Wheaton, Wil
# Madonna

# oversharing?
class Tweet
  attr_accessor :status
  attr_reader :created_at # doesn't define a setter*
  def initialize(status)
    @status = status
    @created_at = Time.new
  end
end

# attr_accessor is both 'getter' and 'setter' methods; like this:
# attr_accessor :baz (is the same as..)

def baz=(value)
  @baz = value
end
def baz
  @baz
end
# shouldn't be able to do the following...
tweet = Tweet.new("Eating breakfast")
tweet.created_at = Time.new(2084, 1, 1, 0, 0, 0, "-07:00") # *means this won't be set

# re-opening a class
tweet = Tweet.new("Eating lunch.")
puts tweet.to_s
# produces: #<Tweet:0x000001008c89e8> which isn't so readable, so you re-open the class and redefine it:


class Tweet
  def to_s
    "#{@status}\n#{@created_at}"
  end
end
tweet = Tweet.new("Eating lunch.")
puts tweet.to_s
# which produces: Eating Lunch.  2012-08-02 12:20:02 -07:00

# self
class UserList
  attr_accessor :name
  def initialize(name)
    name = name # this just re-sets the "name" local variable
  end
end
list = UserList.new('Celebrities')
list.name # which produces 'nil'

class UserList
  attr_accessor :name
  def initialize(name)
    self.name = name # but this calls "name=" on the current object
  end
end
list = UserList.new('Celebrities')
list.name # which produces 'Celebrities'