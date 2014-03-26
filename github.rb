require 'data_mapper'
require 'open-uri'
require 'json'
require 'base64'
require 'redcarpet'

env = ENV['RACK_ENV'] || 'development'
db = ENV['DATABASE_URL'] || "postgres://@localhost/github_cv_#{env}"
DataMapper.setup(:default, db)

# github user data
class Github
  include DataMapper::Resource
  property :id,     Serial
  property :username,  String
  property :repos_url,  String
  property :cv_url,  String
  validates_presence_of :username, :repos_url, :cv_url

  def populate_attributes
    self.repos_url = "https://api.github.com/users/#{username}/repos"
    repos = fetch_json repos_url

    repo_names = repos.map { |repo| repo[:name] }
    cv_name = repo_names.grep(/^(c\.{0,1}v\.{0,1}|curriculum vitae)$/i).first
    # repo = repos.find { |r| r[:name] == 'CV' }
    self.cv_url = "https://api.github.com/repos/#{username}/#{cv_name}/readme"
  end

  def cv_plain
    encoded = fetch_cv[:content]
    Base64.decode64(encoded)
  end

  def cv_html
    markdown = Redcarpet::Markdown.new(
      Redcarpet::Render::HTML,
      autolink: true,
      tables: true,
      no_intra_emphasis: true,
      fenced_code_blocks: true,
      disable_indented_code_blocks: true,
      strikethrough: true
    )
    markdown.render(cv_plain)
  end

  def fetch_cv
    fetch_json cv_url
  end

  private

  def fetch_json(uri)
    raw_data = open(uri).read
    JSON.parse(raw_data, symbolize_names: true)
  end

end

DataMapper.finalize
DataMapper.auto_upgrade!
