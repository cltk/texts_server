class TextNode < ApplicationRecord
  MULTIPLIER = 2**24

  validates :key, presence: true, uniqueness: true

  private

  def gen_key
    self.key = loop do
      random_key = rand(MULTIPLIER).to_s(32)
      break random_key unless TextNode.exists?(key: random_key)
    end
  end
end
