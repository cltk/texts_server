class TextNode < ApplicationRecord
  MULTIPLIER = 2**24

  before_validation :ensure_key!

  validates :key, presence: true, uniqueness: true

  belongs_to :user, optional: true

  def ensure_key!
    return unless key.nil?

    update(key: TextNode.gen_key)
  end

  private

  def self.gen_key
    loop do
      random_key = rand(MULTIPLIER).to_s(32)
      break random_key unless TextNode.exists?(key: random_key)
    end
  end
end
