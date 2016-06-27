require 'rails_helper'

RSpec.describe Indexer do
  subject(:indexer) { Indexer.new }
  describe '.index' do
    it 'indexes a text' do
      expect(indexer.index('running on a hill with the children')[:terms]).to eq(%w(run on hill with children))
    end
  end
end
