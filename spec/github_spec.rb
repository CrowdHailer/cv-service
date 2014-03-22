require './github'

describe Github do
  let (:user) { Github.new(username: 'CrowdHailer') }
  let (:empty_user) { Github.new }

  it 'should be initialized with a username' do
    expect(user.username).to eq('CrowdHailer')
    expect(user).to be_valid
  end

  it 'should require a username' do
    expect(empty_user).not_to be_valid
  end

  it 'should return a users api uri' do
    expect(user.stats_uri).to eq('https://api.github.com/users/CrowdHailer')
  end
end