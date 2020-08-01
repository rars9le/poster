class User < ApplicationRecord
  before_save { self.email.downcase! }
  validates :alias_name, presence: true,                      # 空でないこと
                         length: { in: 5..15 },               # 長さ5～15文字であること
                         format: { with: /\A[a-z0-9_]+\z/i},  # 英数アンダースコアのみ
                         uniqueness: true                     # 一意であること
  validates :name, presence: true, length: { maximum: 50 }
  validates :self_introduction, length: { maximum: 500 }
  validates :image, allow_blank: true, length: { maximum: 255 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
                    
  has_secure_password
  
  has_many :simpleposts
  has_many :relationships
  has_many :followings, through: :relationships, source: :follow
  has_many :reverses_of_relationship, class_name: 'Relationship', foreign_key: 'follow_id'
  has_many :followers, through: :reverses_of_relationship, source: :user
  has_many :favorites
  has_many :likes, through: :favorites, source: :simplepost
  
  def follow(other_user)
    unless self == other_user
      self.relationships.find_or_create_by(follow_id: other_user.id)
    end
  end

  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end

  def following?(other_user)
    self.followings.include?(other_user)
  end
  
  def favorite(simplepost)
    self.favorites.find_or_create_by(simplepost_id: simplepost.id)
  end

  def unfavorite(simplepost)
    favorite = self.favorites.find_by(simplepost_id: simplepost.id)
    favorite.destroy if favorite
  end

  def likes?(simplepost)
    self.likes.include?simplepost
  end
  
  def feed_simpleposts
    Simplepost.where(user_id: self.following_ids + [self.id])
  end
end
