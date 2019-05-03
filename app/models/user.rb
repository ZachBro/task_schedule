class User < ApplicationRecord
  has_secure_password
  validates :name, presence: true, length: {maximum: 20},
                   uniqueness: {case_sensitive: false}
  validates :password, presence: true, length: { minimum: 6 }
  before_save :capitalise_name

  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  private

    def capitalise_name
      name.capitalize!
    end
end
