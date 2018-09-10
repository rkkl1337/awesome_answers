class User < ApplicationRecord
    has_secure_password
    # Requirements:
    # - Install the "bcrypt" gem
    # - A "password_digest" column
  
    # It adds utility methods:
    # - It will add an attribute accessor for `password`
    #   which allows to set a `password` on user without
    #   saving it as plain text.
    # - It adds a presence validation for the `password`
    #   attribute accessor.
    # - It will save passwords as a hashed version of it
    #   in the `password_digest` column.
    # - It will add a method named `authenticate` to verify
    #   a user's password. If called with the correct password,
    #   it returns the user instance. Otherwise, it returns false.
    # - Adds an optional `password_confirmation` attribute accessor.
    #   When used, there's a validation that verifies that it
    #   matches the value of the `password` attribute.
  
    has_many :questions, dependent: :nullify
    has_many :answers, dependent: :nullify
    # validates :password, length: { minimum: 10 }
  
    validates :first_name, :last_name, presence: true
  
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
    #                   |          |@| 
    #                   | steve    |@|codecore |.com
    #         INVALID   | jim%bob  |@|B*zz     |,gov
  
    # The following validation will check that the email is present,
    # that it is unique and that it respects a certain format.
    # To test the format, we use a regular expression. Regular expressions
    # are not unique to Ruby. You can think of them as a mini programming
    # language verifying the shape of strings.
    # To learn more, check out https://regexone.com/
  
    validates(
      :email,
      presence: true,
      uniqueness: true,
      format: VALID_EMAIL_REGEX
    )

    def full_name
        first_name + " " + last_name
    end
  end