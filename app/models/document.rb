# Stores the full text in the database.
class Document < ActiveRecord::Base
  has_and_belongs_to_many :terms

  validates :body, presence: true

  after_save :index_document

  def self.search(query_string)
    indexer = Indexer.new
    query_terms = indexer.index(query_string)
    if query_terms[:terms].present?
      sql = %q(
      SELECT
      documents.*
      FROM documents
      INNER JOIN documents_terms ON documents_terms.document_id = documents.id
      INNER JOIN terms ON documents_terms.term_id = terms.id
      WHERE terms.term = ?
      )
      Document.find_by_sql([Array.new(query_terms[:terms].size, sql).join(' INTERSECT '), *query_terms[:terms]])
    else
      []
    end
  end

  def index_document
    # Remove the old connections to terms
    terms.delete_all
    # Index the document and create the connections with the terms in it
    indexer = Indexer.new
    result = indexer.index(body)
    if result[:terms].present?
      # Prevent duplicates with set
      Set.new.merge(result[:terms]).each do |term|
        terms << Term.find_or_create_by(term: term)
      end
    end
    # After this the term frequency and term count could be updated...
  end
end
