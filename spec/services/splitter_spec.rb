require 'rails_helper'

RSpec.describe Splitter do
  let(:app) { spy('app') }

  describe '.initialize' do
    context 'without parameter' do
      it 'can not create new instance' do
        expect { Splitter.new }.to raise_error(ArgumentError)
      end
    end
    context 'with parameter' do
      it 'creates new instance' do
        stemmer = Splitter.new app
        expect(stemmer.class).to eq(Splitter)
      end
    end
  end

  describe '.call' do
    let(:stemmer) { Splitter.new app }
    let(:env) { { text: 'running coming text' } }
    it 'calls the next middleware' do
      stemmer.call(env)
      expect(app).to have_received(:call)
    end

    it 'splits the text into terms' do
      stemmer.call(env)
      expect(env[:terms]).to eq(['running', 'coming', 'text'])
    end
  end
end
