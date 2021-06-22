require 'rack'
require_relative 'middleware/format_time'

class App
  def call(env)
    request = Rack::Request.new(env)
    get_request(request)
  end

  private

  def get_request(request)
    case request.path
    when  "/time"
      format_request(request)
    else
      response(status: 404, body: 'Not Found')
    end
  end

  def format_request(request)
    form_time = FormatTime.new(request.params['format'])

    if form_time.apply?
      response(status: 200, body: form_time.return_date)
    else
      response(status: 400, body: form_time.return_date)
    end
  end

  def response(status:, headers: { 'Content-Type' => 'text/plain' }, body:)
    [status, headers, [body]]
  end
end
