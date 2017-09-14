class Work < ApplicationRecord
  include PgSearch

  belongs_to :author
  belongs_to :corpus
  belongs_to :language

  has_many :text_nodes

  pg_search_scope :search_by_title, against: :title
end
