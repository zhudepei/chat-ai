class CharactersController < ApplicationController
  before_action :set_character, only: %i[ show update destroy ]

  def index
    @characters = Character.all
  end

  def show
  end

  def create
    @character = Character.new(character_params)
    avatar = ActiveStorage::Blob.find(params[:file_id])
    @character.avatar = avatar

    response = RestClient::Request.execute(
      method: :get,
      url: "#{ENV['GOLAND_SERVER_URL']}/audio?#{URI.encode_uri_component("type=d-id&content=        &image=#{avatar.url}")}",
      raw_response: true,
    )

    response.file

    if @character.save
      render :show, status: :created, location: @character
    else
      render json: @character.errors, status: :unprocessable_entity
    end
  end

  def update
    if @character.update(character_params)
      render :show, status: :ok, location: @character
    else
      render json: @character.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @character.destroy
  end

  private

  def set_character
    @character = Character.find(params[:id])
  end

  def character_params
    params.require(:character).permit(:name)
  end
end
