class Question < ApplicationRecord
    belongs_to :user
    # The model with the method `has_many` should never have
    # the foreign key in the association.


    # Set the option `dependent: :destroy` tot have all associated
    # records be destroyed before the record itself to get around
    # a foreign key constraint.
    has_many :answers, dependent: :destroy

      # `has_many :answers` adds the following instance
        # methods to the Question model:

        # answers
        # answers<<(object, ...)
        # answers.delete(object, ...)
        # answers.destroy(object, ...)
        # answers=(objects)
        # answer_ids
        # answer_ids=(ids)
        # answers.clear
        # answers.empty?
        # answers.size
        # answers.find(...)
        # answers.where(...)
        # answers.exists?(...)
        # answers.build(attributes = {}, ...)
        # answers.create(attributes = {})
        # answers.create!(attributes = {})
        # answers.reload

    # `validates` is a method provided by
    # the superclass that can be used to enforce rules
    # on the shape of data that is saved your db.

    # - The first arguments(s) are column names as symbols
    # - The last arguments are named arguments that describe
    #   the enforced rule
    validates(:title, presence: true, uniqueness: true)
    # The `presence` rule means that the "title" column could not be empty"
    # The `uniqueness` rule means that all questions must have
    # different titles.

    # When a model fails a validation, you can check its
    # errors by using the instance method `errors`.
    # For more readable error messages, use `.errors.full_messages`
    validates(
        :body, 
        presence: {
            message: "must be given" # Provide custom error message
        },
        length: {
            minimum: 10,
            maximum: 280
        }
    )

    validates(
        :view_count,
        numericality: {
            greater_than_or_equal_to: 0
        }
    )

    # You can verify that a model instance (i.e. record)
    # succeeds its validation without saving the record by
    # calling the ".valid?" method on it. It returnsa 'true'
    # if successful; `false`, otherwise.
    # Example: `q.valid?`

    validate(:no_monkey)

    # `before_validation` is a lifecycle callback method that allows
    # respond to event during the life a model instance (e.q.g being validated,
    # being created, being uodated, etc)

    # All lifecycle callback methods take a symbol named after a method
    # and calls that method at the appropriate time.
    before_validation(:set_default_view_count)

    # For all availavble methods, go to:
    # https://api.rubyonrails.org/classes/ActiveRecord/Callbacks.html

    # Create a scope with a class method

    scope(:recent, -> { order(created_at: :desc).limit(10) })
    # Scopes are such a commonly used feature that there's to
    # # create them quicker. It takes a name and lambda as a callback.
    # def self.recent
    #     order(created_at: :desc).limit(10)
    # end

    scope(:search, -> (query) { where("title ILIKE ? OR body ILIKE ?", "%#{query}%", "%#{query}%" )})
    # def self.search(query)
    #     where("title ILIKE ? OR body ILIKE ?", "%#{query}%", "%#{query}%")
    # end

    private
    def set_default_view_count
        # If you are writing to an attribute accessor, you
        # must prefix with `self.` which do not have to do
        # if you're just reading it instead.

        # self.view_count = 0 if self.view_count.nil?
        # self.view_count = self.view_count || 0 
        # ⬇️ is syntax sugar for
        self.view_count ||= 0

    # The elusive or-equal will only assign to its left-land side
    # if it is  'nil'
    end

    def no_monkey
        # `&.` is the safe navigation operator.
        # It allows to chain methods together without worrying
        # about one returning `nil`.
        # If the value before `&.` is `nil`, then `nil`
        # will be returned skipping all further method calls in the chain.
        # This avoids the "undefined method for nil:NilClass" error.

        if body&.downcase&.include?("monkey")
            errors.add(:body, "must not have a monkey")
        end
    end
end
