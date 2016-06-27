class CreateDocumentsTerms < ActiveRecord::Migration
  def change
    create_table :documents_terms, index: false do |t|
      t.belongs_to :document, index: true, foreign_key: true
      t.belongs_to :term, index: true, foreign_key: true
    end
  end
end
