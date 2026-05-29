class OwnerPolicy < ApplicationPolicy
  def index?
    user.admin? || user.vet?
  end

  def show?
    user.admin? || user.vet? || own_record?
  end

  def create?
    user.admin?
  end

  def update?
    user.admin? || own_record?
  end

  def destroy?
    user.admin?
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      if user.admin? || user.vet?
        scope.all
      elsif user.owner?
        scope.where(user_id: user.id)
      else
        scope.none
      end
    end
  end

  private

  def own_record?
    user.owner? && record.user_id == user.id
  end
end