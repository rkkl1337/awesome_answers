class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
      user ||= User.new # guest user (not logged in)
      if user.admin?
        can :manage, :all
      else
        can :read, :all
      end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
    
    # With the method, `can` we define the abilities (e.g. permissions) 
    # of users with the `initialize` of this class.
    # `can` takes a symbol that represents an action to be performed
    # on a thing as its first argument. These can be any word of your choice
    # (e.g. :create, :read, :update:, :like, :dislike, :poke, etc)

    # alias_action :crud, to: [:create, :read, :update, :delete]
    alias_action :create, :read, :update, :delete, to: :crud

    # It also takes a second argument that is the class of the thing
    # we want to perform an action on which is typically a model.

    # To translate the one below in English:
    # The current user can manage instance of the Question class
    # that they own (associated to them).
    # can :manage, Question do |question|
    can :crud, Question do |question|
      # Inside of this `initialize`, `user` refers to the `current_user`
      user == question.user
    end
    # To test this ability on an instance of a class, user 'can?' like so:
    # can?(:crud, @question)
    # where `:crud` is an action name we've defined in our ability
    # file and `@question` is an object (or an instance of a class)
    # 

    can :crud, Answer do |answer|
      user == answer.user
    end
  end
end
