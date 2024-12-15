class User < ApplicationRecord
  # enum profile: { admin: 0, client: 1 }
  has_secure_password
  # mount_uploader :avatar, AvatarUploader
  validates :email, presence: true, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true,
            length: { minimum: 6 }, on: :create,
            if: -> { new_record? || !password.nil? }

  # Aula sobre JWT acho que já valida isso >> validates :name, presence: true
  # validates :profile, presence: true
end
# Validação da presença da senha.
# Criação de um método authenticate para verificar se a senha fornecida está correta.
