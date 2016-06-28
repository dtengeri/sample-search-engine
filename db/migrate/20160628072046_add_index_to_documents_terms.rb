class AddIndexToDocumentsTerms < ActiveRecord::Migration
  def change
    add_index :documents_terms, [:document_id, :term_id], unique: true
  end
end
