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

  has_many :friendships
  has_many :friends, :through => :friendships    
  has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"
  has_many :inverse_friends, :through => :inverse_friendships, :source => :user

  mount_uploader :uploader_image, ImageUploader
    
  geocoded_by :address do |user,results|
    if geo = results.first
      user.city = geo.city
      user.state = geo.state_code
      user.latitude = geo.latitude.to_f
      user.longitude = geo.longitude.to_f
    end
  end
  after_validation :geocode, :if => :address_changed?

  has_many :sent_messages, :class_name => "Message", :foreign_key => "author_id"
  has_many :received_messages, :class_name => "MessageCopy", :foreign_key => "recipient_id"

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

  def profile_stats
    if single_parent == "1"
      answer = "is a single parent"
    end
    if new_parent == "1"
      answer = "is a new parent"
    end
    if non_parent == "1"
      answer = "is a non-parent"
    end
    answer
    if single_parent == "0" && new_parent == "0" && non_parent == nil
      if gender == "Male"
        first = ("is a dad living").html_safe
    end
      if gender == "Female"
        first = ("is a mom living").html_safe
      end
    end
    first
  end

  def kid_stats
    if self.gender == "Female"
      if self.single_parent.present? || self.new_parent.present? || self.non_parent.present?
        if self.children_under_5.present?
          answer = ("She has children <strong>under five</strong>.").html_safe
        end
        if self.special_needs.present?
          answer = ("She is a parent of <strong>special needs</strong> children.").html_safe
        end
        if self.children_5_10.present?
          answer = ("She has children <strong>five to ten</strong> years in age.").html_safe
        end
        if self.teens.present?
          answer = ("She is a parent of <strong>teenagers</strong>.").html_safe
        end
        if self.tweens == "1"
          answer = ("She is a parent of <strong>tweens</strong>.").html_safe
        end
      end
    end
     if self.gender == "Male"
      if self.single_parent.present? || self.new_parent.present? || self.non_parent.present?
        if self.children_under_5.present?
          answer = ("He has children <strong>under five</strong>.").html_safe
        end
        if self.special_needs.present?
          answer = ("He is a parent of <strong>special needs</strong> children.").html_safe
        end
        if self.children_5_10.present?
          answer = ("He has children <strong>five to ten</strong> years in age.").html_safe
        end
        if self.teens.present?
          answer = ("He is a parent of <strong>teenagers</strong>.").html_safe
        end
        if self.tweens.present?
          answer = ("He is a parent of <strong>tweens</strong>.").html_safe
        end
      end
    end
    answer
  end

  def parent_interests
    if gender = "Mom" && self.following.count >= 3
      first_interest = following.order("RANDOM()").first.name
      second_interest = following.where('name <> ?', first_interest).order("RANDOM()").first.name
      third_interest = following.where('name <> ? AND name <>?', first_interest, second_interest).first.name
      ("Her interests include <strong>#{first_interest}</strong>, <strong>#{second_interest}</strong> and <strong>#{third_interest}</strong>.").html_safe
    end
    if gender = "Dad" && self.following.count >= 3
      first_interest = following.order("RANDOM()").first.name
      second_interest = following.where.not(name: first_interest).order("RANDOM()").first.name
      third_interest = following.where('name <> ? AND name <>?', first_interest, second_interest).first.name
      ("His interests include <strong>#{first_interest}</strong>, <strong>#{second_interest}</strong> and <strong>#{third_interest}</strong>.").html_safe
    end
  end

    def parent_activities
    if self.gender = "Mom" && self.activity_following.count > 2
      first_activity = activity_following.order("RANDOM()").first.title
      second_activity = activity_following.where('title <> ?', first_activity).first.title.truncate(33)
      ("Some of her activities include '#{first_activity.truncate(33)}'</strong> and <strong>'#{second_activity}'.").html_safe
    end
    if self.gender = "Dad" && self.activity_following.count > 2
      first_activity = activity_following.order("RANDOM()").first.title
      second_activity = activity_following.where.not(title: first_activity).first.title.truncate(33)
      ("Some of his activities include '#{first_activity.truncate(33)}' and '#{second_activity}'.").html_safe
    end
  end

  def new_messages
    received_messages.where('read_at IS ?', nil).count
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
