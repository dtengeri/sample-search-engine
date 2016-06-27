# A term is a searchable word. It is connected to several documents
class Term < ActiveRecord::Base
  has_and_belongs_to_many :documents

  validates :term, presence: true
end
