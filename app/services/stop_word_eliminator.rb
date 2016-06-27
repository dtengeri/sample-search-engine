# Middleware that eliminates unusable words
class StopWordEliminator
  STOP_WORDS = %w(a an the ,)

  def initialize(app)
    @app = app
  end

  def call(env)
    env[:terms] = env[:terms].select { |term| !STOP_WORDS.include? term }
    @app.call(env)
  end
end
