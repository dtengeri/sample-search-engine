# Service that processes a text and returns an array of terms
# Build by using the middleware pattern.
class Indexer
  def initialize
    @stack = Middleware::Builder.new do
      use Replacer
      use Converter
      use Splitter
      use StopWordEliminator
      use FastStemmer
    end
  end

  def index(text)
    @env = {
      text: text
    }
    @stack.call(@env)
    @env
  end
end
