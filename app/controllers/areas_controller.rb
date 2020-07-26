# frozen_string_literal: true

class AreasController < ApplicationController
  before_action :set_area, only: %i[show edit update destroy]

  # GET /areas
  def index
    @areas = Area.all
  end

  # GET /areas/1
  def show
    @json_entries = @area.json_entries
    @items = @area.items.order(id: :desc)
  end

  # GET /areas/new
  def new
    @area = Area.new
  end

  # GET /areas/1/edit
  def edit; end

  # POST /areas
  def create
    @area = current_user.areas.new(area_params)

    if @area.save
      redirect_to @area, notice: "Area was successfully created."
    else
      render :new
    end
  end

  # PATCH/PUT /areas/1
  def update
    if @area.update(area_params)
      redirect_to @area, notice: "Area was successfully updated."
    else
      render :edit
    end
  end

  # DELETE /areas/1
  def destroy
    @area.destroy
    redirect_to areas_url, notice: "Area was successfully destroyed."
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_area
    @area = Area.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def area_params
    params.require(:area).permit(:name)
  end
end
