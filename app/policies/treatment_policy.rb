class TreatmentPolicy < ApplicationPolicy
  def create?
    user.admin? || assigned_vet?
  end

  def update?
    user.admin? || assigned_vet?
  end

  def destroy?
    user.admin? || assigned_vet?
  end

  private

  def assigned_vet?
    user.vet? && record.appointment&.vet&.user_id == user.id
  end
end