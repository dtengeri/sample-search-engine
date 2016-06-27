require 'rails_helper'

RSpec.describe Converter do
  let(:app) { spy('app') }

  describe '.initialize' do
    context 'without parameter' do
      it 'can not create new instance' do
        expect { Converter.new }.to raise_error(ArgumentError)
      end
    end
    context 'with parameter' do
      it 'creates new instance' do
        stemmer = Converter.new app
        expect(stemmer.class).to eq(Converter)
      end
    end
  end

  describe '.call' do
    let(:converter) { Converter.new app }
    let(:env) { { text: 'ruNNing cOming Text' } }
    it 'calls the next middleware' do
      converter.call(env)
      expect(app).to have_received(:call)
    end

    it 'replaces unusable characters in the text' do
      converter.call(env)
      expect(env[:text]).to eq('running coming text')
    end
  end
end
