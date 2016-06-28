# Middleware that splits text into chunks
class Splitter
  def initialize(app)
    @app = app
  end

  def call(env)
    if env[:text].present?
      parts = Set.new
      parts.merge env[:text].split
      env[:terms] = parts.to_a
    end

    @app.call(env)
  end
end
