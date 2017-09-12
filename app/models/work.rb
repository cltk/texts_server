class Work < ApplicationRecord
  belongs_to :author
  belongs_to :corpus
  belongs_to :language

  has_many :text_nodes

end
