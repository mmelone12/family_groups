class Folder < ActiveRecord::Base
  include ActsAsTree

  acts_as_tree
  belongs_to :user
  has_many :messages, :class_name => "MessageCopy"
end
