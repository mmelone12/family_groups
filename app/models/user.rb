class User < ActiveRecord::Base
  before_save { self.email = email.downcase }
	before_create :create_remember_token

	validates :name, presence: true, length: { maximum: 50 }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, 
			  format: { with: VALID_EMAIL_REGEX },
		      uniqueness: { case_sensitive: false }
  validates :address, presence: true
    has_secure_password
    validates :password, length: { minimum: 6 }

  has_many :relationships, :foreign_key => "follower_id",
                            :dependent => :destroy   
  has_many :following, :through => :relationships, :source => :followed

  has_many :group_relationships, :foreign_key => "group_follower_id",
                            :dependent => :destroy   
  has_many :group_following, :through => :group_relationships, :source => :group_followed

  has_many :groups, dependent: :destroy 

  has_many :activity_relationships, :foreign_key => "activity_follower_id",
                            :dependent => :destroy   
  has_many :activity_following, :through => :activity_relationships, :source => :activity_followed

  has_many :activities, dependent: :destroy 

  has_many :place_relationships, :foreign_key => "place_follower_id",
                            :dependent => :destroy   
  has_many :place_following, :through => :place_relationships, :source => :place_followed

  has_many :places, dependent: :destroy 
    
  geocoded_by :address do |user,results|
    if geo = results.first
      user.city = geo.city
      user.state = geo.state_code
      user.latitude = geo.latitude.to_f
      user.longitude = geo.longitude.to_f
    end
  end
  after_validation :geocode, :if => :address_changed?

  def following?(interest)
    relationships.find_by(followed_id: interest.id)
  end

  def follow!(interest)
    relationships.create!(followed_id: interest.id)
  end

  def unfollow!(interest)
    relationships.find_by(followed_id: interest.id).destroy!
  end

  def group_following?(group)
    group_relationships.find_by(group_followed_id: group.id)
  end

  def group_follow!(group)
    group_relationships.create!(group_followed_id: group.id)
  end

  def group_unfollow!(group)
    group_relationships.find_by(group_followed_id: group.id).destroy!
  end

  def activity_following?(activity)
    activity_relationships.find_by(activity_followed_id: activity.id)
  end

  def activity_follow!(activity)
    activity_relationships.create!(activity_followed_id: activity.id)
  end

  def activity_unfollow!(activity)
    activity_relationships.find_by(activity_followed_id: activity.id).destroy!
  end

  def place_following?(place)
    place_relationships.find_by(place_followed_id: place.id)
  end

  def place_follow!(place)
    place_relationships.create!(place_followed_id: place.id)
  end

  def place_unfollow!(place)
    place_relationships.find_by(place_followed_id: place.id).destroy!
  end

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  private

    def create_remember_token
      self.remember_token = User.encrypt(User.new_remember_token)
    end
end
