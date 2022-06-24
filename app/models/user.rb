class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  has_many :wallets, dependent: :destroy
  has_many :cardano_addresses, through: :wallets

  validates :first_name, :last_name, presence: true
  validates :orcid_id, uniqueness: true, allow_nil: true

  def active_model_serializer
    UserSerializer
  end

  def reset_password!(password)
    self.reset_password_token = nil
    self.password = password
    save!
  end
end
