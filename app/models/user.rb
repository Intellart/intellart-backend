class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :confirmable, :validatable

  validates :first_name, presence: true
  validates :orcid_id, uniqueness: true, allow_nil: true

  has_many :articles, foreign_key: 'author_id', dependent: :destroy
  has_many :comments, as: :commenter, dependent: :destroy

  has_many :user_reviews, dependent: :destroy
  has_many :reviews, through: :user_reviews
  has_many :evaluations, foreign_key: 'rating_subject_id', class_name: 'Rating', dependent: :destroy
  has_many :ratings, dependent: :destroy
  has_and_belongs_to_many :collaborations, class_name: 'Article', join_table: 'articles_users', foreign_key: 'user_id'

  before_validation :normalize_orcid_id

  include Rateable

  def full_name
    "#{first_name} #{last_name}"
  end

  def reset_password!(password)
    self.reset_password_token = nil
    self.password = password
    save!
  end

  private

  def normalize_orcid_id
    self.orcid_id = nil if orcid_id.blank?
  end

end
