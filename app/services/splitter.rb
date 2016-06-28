# Middleware that splits text into chunks
class Splitter
  def initialize(app)
    @app = app
  end

  def call(env)
    env[:terms] = env[:text].split if env[:text].present?
    @app.call(env)
  end
end
