class User < ActiveRecord::Base
  has_secure_password
  has_many :requests
  has_many :given_loans,
           :class_name => 'Transaction',
           :foreign_key => 'lender_id'

  has_many :rcvd_loans,
           :class_name => 'Transaction',
           :foreign_key => 'borrower_id'

  VALID_EMAIL_REGEX = /\A([\w+\-]\.?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: {message: "has already been taken", :case_sensitive => false}
validates_format_of :email, :with => VALID_EMAIL_REGEX

end
