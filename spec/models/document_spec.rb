require 'rails_helper'

RSpec.describe Document, type: :model do
  subject(:document) { Document.new(body: 'running on a hill with the children') }

  describe '.save' do
    it 'indexes the content' do
      document.save
      expect(document.terms.map(&:term)).to eq(%w(run on hill with children))
    end

    it 're-indexes the content after update' do
      document.save
      document.update_attributes(body: 'running on a hill with the dog')
      expect(document.terms.map(&:term)).to eq(%w(run on hill with dog))
    end

    it 'connects with a term only once' do
      document.body = 'running on a hill with the children and with the dogs'
      document.save
      expect(document.terms.map(&:term)).to eq(%w(run on hill with children and dog))
    end
  end

  describe '#search' do
    before do
      Document.create(body: 'running on a hill with the children')
      Document.create(body: 'children like icecream with chocolate')
      Document.create(body: 'going out with my friend')
    end

    context 'with one search term' do
      it 'finds the relevant documents' do
        expect(Document.search('with').size).to eq(3)
      end
      it 'returns empty result if no documents found' do
        expect(Document.search('family').size).to eq(0)
      end
    end
    context 'with multiple search term' do
      it 'finds the relevant documents' do
        expect(Document.search('with children').size).to eq(2)
      end
      it 'returns empty result if no documents found' do
        expect(Document.search('family holiday').size).to eq(0)
      end
    end
  end
end
