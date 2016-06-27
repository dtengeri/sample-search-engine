require 'rails_helper'

RSpec.describe FastStemmer do
  let(:app) { spy('app') }

  describe '.initialize' do
    context 'without parameter' do
      it 'can not create new instance' do
        expect { FastStemmer.new }.to raise_error(ArgumentError)
      end
    end
    context 'with parameter' do
      it 'creates new instance' do
        stemmer = FastStemmer.new app
        expect(stemmer.class).to eq(FastStemmer)
      end
    end
  end

  describe '.call' do
    let(:stemmer) { FastStemmer.new app }
    let(:env) { { terms: %w(running coming) } }
    it 'calls the next middleware' do
      stemmer.call(env)
      expect(app).to have_received(:call)
    end

    it 'stems the terms in env' do
      stemmer.call(env)
      expect(env[:terms]).to eq(%w(run come))
    end
  end
end
