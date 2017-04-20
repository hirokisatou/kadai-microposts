class User < ApplicationRecord
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  
  has_many :microposts, :dependent => :destroy
  has_many :relationships
  has_many :followings, through: :relationships, source: :follow
  has_many :reverses_of_relationship, class_name: 'Relationship', foreign_key: 'follow_id'
  has_many :followers, through: :reverses_of_relationship, source: :user
  
  has_many :favos, :dependent => :destroy
  has_many :favo_microposts, through: :favos, source: :micropost
  has_many :reverses_of_favo, class_name: 'Favo', foreign_key: 'micropost_id'
  has_many :favo_users, through: :reverses_of_favo, source: :user
  
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
  
  def feed_microposts
    Micropost.where(user_id: self.following_ids + [self.id])
  end
  
  def favo(micropost)
    self.favos.find_or_create_by(micropost_id: micropost.id)
  end

  def unfavo(micropost)
    favo = self.favos.find_by(micropost_id: micropost.id)
    favo.destroy if favo
  end

  def favo?(micropost)
    self.favo_microposts.include?(micropost)
  end
  
end
