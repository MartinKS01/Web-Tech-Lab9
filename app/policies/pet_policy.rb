class PetPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    true
  end

  def create?
    user.admin? || user.owner?
  end

  def update?
    user.admin? || own_pet?
  end

  def destroy?
    user.admin? || own_pet?
  end

  def permitted_attributes
    if user.admin?
      [:name, :species, :breed, :date_of_birth, :weight, :owner_id, :photo]
    else
      [:name, :species, :breed, :date_of_birth, :weight, :photo]
    end
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      if user.admin? || user.vet?
        scope.all
      elsif user.owner?
        owner = Owner.find_by(user_id: user.id)
        owner ? scope.where(owner_id: owner.id) : scope.none
      else
        scope.none
      end
    end
  end

  private

  def own_pet?
    user.owner? && record.owner&.user_id == user.id
  end
end