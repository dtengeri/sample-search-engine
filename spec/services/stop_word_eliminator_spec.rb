require 'rails_helper'

RSpec.describe StopWordEliminator do
  let(:app) { spy('app') }

  describe '.initialize' do
    context 'without parameter' do
      it 'can not create new instance' do
        expect { StopWordEliminator.new }.to raise_error(ArgumentError)
      end
    end
    context 'with parameter' do
      it 'creates new instance' do
        stemmer = StopWordEliminator.new app
        expect(stemmer.class).to eq(StopWordEliminator)
      end
    end
  end

  describe '.call' do
    let(:stemmer) { StopWordEliminator.new app }
    let(:env) { { terms: %w(a text and the string) } }
    it 'calls the next middleware' do
      stemmer.call(env)
      expect(app).to have_received(:call)
    end

    it 'eliminates stop words' do
      stemmer.call(env)
      expect(env[:terms]).to eq(%w(text and string))
    end
  end
end
