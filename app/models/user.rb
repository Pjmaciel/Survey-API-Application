class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: { user: 'user', coordinator: 'coordinator', admin: 'admin' }

  def coordinator?
    role == 'coordinator'
  end
end
