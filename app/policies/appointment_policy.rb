class AppointmentPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    user.admin? || assigned_vet? || own_appointment?
  end

  def create?
    user.admin? || user.vet? || user.owner?
  end

  def update?
    user.admin? || assigned_vet? || own_appointment?
  end

  def destroy?
    user.admin? || assigned_vet? || own_appointment?
  end

  def permitted_attributes
    if user.admin?
      [:pet_id, :vet_id, :date, :reason, :status]
    elsif user.vet?
      [:date, :reason, :status]
    else
      [:pet_id, :date, :reason, :status]
    end
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      if user.admin?
        scope.all
      elsif user.vet?
        vet = Vet.find_by(user_id: user.id)
        vet ? scope.where(vet_id: vet.id) : scope.none
      elsif user.owner?
        owner = Owner.find_by(user_id: user.id)
        owner ? scope.joins(:pet).where(pets: { owner_id: owner.id }) : scope.none
      else
        scope.none
      end
    end
  end

  private

  def assigned_vet?
    user.vet? && record.vet&.user_id == user.id
  end

  def own_appointment?
    user.owner? && record.pet&.owner&.user_id == user.id
  end
end