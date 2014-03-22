require './github'

describe Github do
  let (:github) { Github.new('CrowdHailer') }

  it 'should be initialized with a username' do
    expect(github.username).to eq('CrowdHailer')
  end
end