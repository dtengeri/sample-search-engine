# Middleware that replaces unusable characters
class Replacer
  def initialize(app)
    @app = app
  end

  def call(env)
    env[:text] = env[:text].gsub(/[,!\-\.;\?]/, '') if env[:text].present?
    @app.call(env)
  end
end
