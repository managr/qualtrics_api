module QualtricsAPI

  class Client
    attr_reader :api_token

    def initialize(options = {})
      @api_token = options[:api_token]
    end

    def surveys(options = {})
      @surveys ||= QualtricsAPI::SurveyCollection.new options.merge({ connection: connection })
    end

    def response_exports(options = {})
      @response_exports ||= QualtricsAPI::ResponseExportCollection.new options.merge({ connection: connection })
    end

    def connection
      @conn ||= Faraday.new(url: QualtricsAPI::URL,
                            params: { apiToken: @api_token }) do |faraday|
        faraday.request :json
        faraday.response :json, :content_type => /\bjson$/

        faraday.use FaradayMiddleware::FollowRedirects
        faraday.use QualtricsAPI::RequestErrorHandler

        faraday.adapter Faraday.default_adapter
      end
    end
  end

end
