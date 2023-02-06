class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :confirmable, :validatable

  validates :first_name, :last_name, presence: true
  validates :orcid_id, uniqueness: true, allow_nil: true

  has_many :blog_articles, class_name: "BlogArticle", foreign_key: "user_id", dependent: :destroy
  has_many :blog_article_comments, class_name: "BlogArticleComment", foreign_key: "commenter_id", dependent: :destroy

  def active_model_serializer
    UserSerializer
  end

  def full_name
    "#{self.first_name} #{self.last_name}"
  end

  def reset_password!(password)
    self.reset_password_token = nil
    self.password = password
    save!
  end
end
