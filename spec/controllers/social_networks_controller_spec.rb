require 'rails_helper'

describe SocialNetworksController, type: :controller do
  let(:headers) do
    {
      'Accept'=>'*/*',
      'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
      'User-Agent'=>'Ruby'
    }
  end
  let(:twitter_response) do
    [
      {
        username: '@GuyEndoreKaiser',
        tweet: 'If you live to be 100, you should make up some fake reason why, just to mess with people... like claim you ate a pinecone every single day.'
      },
      {
        username: '@mikeleffingwell',
        tweet: "STOP TELLING ME YOUR NEWBORN'S WEIGHT AND LENGTH I DON'T KNOW WHAT TO DO WITH THAT INFORMATION."
      }
    ]
  end

  let(:facebook_response) do
    [
      {
        name: 'Some Friend',
        status: "Here's some photos of my holiday. Look how much more fun I'm having than you are!"
      },
      {
        name: 'Drama Pig',
        status: 'I am in a hospital. I will not tell you anything about why I am here.'
      }
    ]
  end

  let(:instagram_response) do
    [
      {
        username: 'hipster1',
        picture: 'food'
      },
      {
        username: 'hipster2',
        picture: 'coffee'
      },
      {
        username: 'hipster3',
        picture: 'coffee'
      },
      {
        username: 'hipster4',
        picture: 'food'
      },
      {
        username: 'hipster5',
        picture: 'this one is of a cat'
      }
    ]
  end

  describe 'GET #index' do
    it 'fetches data from social media api' do
      stub_request(:get, 'https://takehome.io/twitter')
        .with(headers: headers).to_return(status: 200, body: twitter_response.to_json)

      stub_request(:get, 'https://takehome.io/facebook')
        .with(headers: headers).to_return(status: 200, body: facebook_response.to_json)

      stub_request(:get, 'https://takehome.io/instagram')
        .with(headers: headers).to_return(status: 200, body: instagram_response.to_json)

      get :index

      parsed_response = JSON.parse(response.body)
      expect(parsed_response['twitter']).to eq(twitter_response.to_json)
      expect(parsed_response['instagram']).to eq(instagram_response.to_json)
      expect(parsed_response['facebook']).to eq(facebook_response.to_json)
    end
  end
end
