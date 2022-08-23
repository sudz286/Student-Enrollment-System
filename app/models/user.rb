class User < ApplicationRecord
    has_secure_password
    validates :name, :password_digest, :email, :phone_number, presence: true
    validates_uniqueness_of :email
    enum role: [:admin, :instructor, :student]
    # has_many :courses, dependent: :destroy
end
