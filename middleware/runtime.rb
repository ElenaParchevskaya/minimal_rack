class Runtime
  def initialize(app)
    @app = app
  end

  def call(env)
    time = Time.now
    status, headers, body = @app.call(env)
    headers['X-Runtime'] = "%fs" % (Time.now - time)

    [status, headers, body]
  end
end
