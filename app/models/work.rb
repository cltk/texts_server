class Work < ApplicationRecord
  belongs_to :author
  belongs_to :corpus
  
  has_many :text_nodes

end
