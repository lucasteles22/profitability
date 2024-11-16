class Report < ApplicationRecord
  belongs_to :user

  scope :debit, -> { where("kind = 'Debito'") }
  scope :credit, -> { where("kind = 'Credito'") }
  scope :with_user, ->(user) { where(user: user) }
end
