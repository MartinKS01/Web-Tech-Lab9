class PetsController < ApplicationController
  before_action :set_pet, only: [:show, :edit, :update, :destroy]

  def index
    @pets = policy_scope(Pet).includes(:owner)
  end

  def show
    authorize @pet
  end

  def new
    @pet = Pet.new
    authorize @pet
  end

  def create
    @pet = Pet.new(permitted_attributes(Pet.new))
    # Force owner to current user's owner record if owner-role
    if current_user.owner?
      @pet.owner = Owner.find_by(user_id: current_user.id)
    end
    authorize @pet
    if @pet.save
      redirect_to @pet, notice: "Pet was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize @pet
  end

  def update
    authorize @pet
    if @pet.update(permitted_attributes(@pet))
      redirect_to @pet, notice: "Pet was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @pet
    @pet.destroy
    redirect_to pets_path, notice: "Pet was successfully deleted."
  end

  private

  def set_pet
    @pet = Pet.find(params[:id])
  end
end