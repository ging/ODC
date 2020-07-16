class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    #Users
    can :read, User

    #Courses
    can :read, Course
    
    unless user.id.nil?
      #Registered users
      can :manage, User do |u|
        u.id === user.id
      end

      can :manage, Course #TODO

    end

  end
end
