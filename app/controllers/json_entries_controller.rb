# frozen_string_literal: true

class JsonEntriesController < ApplicationController
  before_action :set_area, only: %i[index new create]
  before_action :set_json_entry, only: %i[show edit update destroy]

  # GET /json_entries
  def index
    @json_entries = @area.json_entries
  end

  # GET /json_entries/1
  def show
    @items = @json_entry.items
  end

  # GET /json_entries/new
  def new
    @json_entry = JsonEntry.new
  end

  # GET /json_entries/1/edit
  def edit; end

  # POST /json_entries
  def create
    @json_entry = @area.json_entries.new(json_entry_params)

    if @json_entry.save
      redirect_to edit_json_entry_path(@json_entry), notice: "Json entry was successfully created."
    else
      render :new
    end
  end

  # PATCH/PUT /json_entries/1
  def update
    if @json_entry.update(json_entry_params)
      redirect_to @json_entry, notice: "Json entry was successfully updated."
    else
      render :edit
    end
  end

  # DELETE /json_entries/1
  def destroy
    @json_entry.destroy
    redirect_to json_entries_url, notice: "Json entry was successfully destroyed."
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_json_entry
    @json_entry = JsonEntry.find(params[:id])
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_area
    @area = Area.find(params[:area_id])
  end

  # Only allow a trusted parameter "white list" through.
  def json_entry_params
    params.require(:json_entry).permit(:area_id, :data, :name, :verb, :post_body)
  end
end
