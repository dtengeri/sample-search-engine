# Middleware stemming words
class FastStemmer
  def initialize(app)
    @app = app
  end

  def call(env)
    env[:terms] = env[:terms].map { |term| term.stem } if env[:terms].present?
    @app.call(env)
  end
end
