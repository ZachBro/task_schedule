class User < ApplicationRecord
  has_secure_password
  validates :name, presence: true, length: {maximum: 20},
                   uniqueness: {case_sensitive: false}
  validates :password, presence: true, length: { minimum: 6 }
  before_save :capitalise_name

  private

    def capitalise_name
      name.capitalize!
    end
end
