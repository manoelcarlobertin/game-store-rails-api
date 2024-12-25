class User < ApplicationRecord
  enum :profile, { admin: 0, client: 1 }
  has_secure_password # permite que você use o método authenticate para verificar a senha.

  validates :email, presence: true, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password_digest, presence: true,
            length: { minimum: 6 }, on: :create,
            if: -> { new_record? || !password.nil? }

  # mount_uploader :avatar, AvatarUploader
  # validates :name, presence: true
  validates :profile, presence: true
  # validates :password_digest, allow_blank: true,
  #           length: { minimum: 6 }, on: :update,
  #           if: -> { password.present? }

  # has_many :products
  # has_many :product_categories
  # has_many :orders
  # has_many :order_items

  def generate_jwt
    payload = { user_id: self.id }
    JWT.encode(payload, Rails.application.credentials.secret_key_base)
  end
end
# Validação da presença da senha.
# Criação de um método authenticate para verificar se a senha fornecida está correta.
