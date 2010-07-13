require 'aidentiti'
class AidentitiToken < ConsumerToken
  
  def self.consumer
    @consumer||=OAuth::Consumer.new credentials[:key],credentials[:secret],credentials[:options]
  end
  
  def client
    unless @client
      aidentiti_oauth = Aidentiti::OAuth.new AidentitiToken.consumer.key,AidentitiToken.consumer.secret,AidentitiToken.consumer.options
      aidentiti_oauth.authorize_from_access token,secret
      @client=Aidentiti::Base.new(aidentiti_oauth)
    end
    @client
  end
  
end