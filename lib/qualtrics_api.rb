require "faraday"
require "faraday_middleware"

require "qualtrics_api/version"
require "qualtrics_api/url"

require "qualtrics_api/request_error_handler"

require "qualtrics_api/client"
require "qualtrics_api/survey"
require "qualtrics_api/survey_collection"

module QualtricsAPI

  def self.new(token)
    Client.new(api_token: token)
  end

end
