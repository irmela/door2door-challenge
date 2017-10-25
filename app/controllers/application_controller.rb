class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  private

  def parse_request_params
    if request.body.size > 0
      request.body.rewind
      request_params = ActiveSupport::JSON.decode(request.body.read)
      params.merge!(request_params)
    end
  end
end
