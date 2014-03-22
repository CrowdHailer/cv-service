class Github
  def initialize username
    @username = username
  end

  attr_reader :username

  def stats_uri
    "https://api.github.com/users/#{username}"
  end

end