class Simplepost < ApplicationRecord
  belongs_to :user
  
  validates :content, presence: true, length: { maximum: 255 }
    
  has_many :favorites, dependent: :destroy
  has_many :favoriter, through: :favorites, source: :users
  
  #Like検索,ない場合は全てを返す
  def self.search(search)
    return Simplepost.all unless search
    Simplepost.where(['content LIKE ?', "%#{search}%"])
  end
  
end
