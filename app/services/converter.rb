# Middleware to convert text to lower case
class Converter
  def initialize(app)
    @app = app
  end

  def call(env)
    env[:text] = env[:text].downcase if env[:text].present?
    @app.call(env)
  end
end
