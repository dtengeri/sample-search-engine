require 'rails_helper'

RSpec.describe Replacer do
  let(:app) { spy('app') }

  describe '.initialize' do
    context 'without parameter' do
      it 'can not create new instance' do
        expect { Replacer.new }.to raise_error(ArgumentError)
      end
    end
    context 'with parameter' do
      it 'creates new instance' do
        stemmer = Replacer.new app
        expect(stemmer.class).to eq(Replacer)
      end
    end
  end

  describe '.call' do
    let(:replacer) { Replacer.new app }
    let(:env) { { text: 'running, coming! text.' } }
    it 'calls the next middleware' do
      replacer.call(env)
      expect(app).to have_received(:call)
    end

    it 'replaces unusable characters in the text' do
      replacer.call(env)
      expect(env[:text]).to eq('running coming text')
    end
  end
end
