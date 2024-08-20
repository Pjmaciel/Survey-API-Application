class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :surveys, dependent: :destroy
  has_many :responses, dependent: :destroy

  ROLE = {
    coordinator: 'coordinator',
    respondent: 'respondent'
  }

  enum role: ROLE, _suffix: true

  validates :name, :email, :password, :role, presence: true
  validates :role, inclusion: { in: roles.keys }

  def coordinator?
    role == 'coordinator'
  end

  def respondent?
    role == 'respondent'
  end
end
