require 'forwardable'
require 'mash'
require 'httparty'

module Aidentiti
  class AidentitiError < StandardError
    attr_reader :data
    
    def initialize(data)
      @data = data
      super
    end
  end
  
  class RateLimitExceeded < AidentitiError; end
  class Unauthorized      < AidentitiError; end
  class General           < AidentitiError; end
  
  class Unavailable   < StandardError; end
  class InformAidentiti < StandardError; end
  class NotFound      < StandardError; end
end

directory = File.expand_path(File.dirname(__FILE__))

require File.join(directory, 'aidentiti', 'oauth')
require File.join(directory, 'aidentiti', 'request')
require File.join(directory, 'aidentiti', 'base')