require './github'

describe Github do
  let (:user) { Github.new(username: 'CrowdHailer') }

  it 'should be initialized with a username' do
    expect(user.username).to eq('CrowdHailer')
  end

  it 'should return a users api uri' do
    expect(user.stats_uri).to eq('https://api.github.com/users/CrowdHailer')
  end
end