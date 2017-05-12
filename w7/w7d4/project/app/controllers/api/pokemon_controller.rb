class Api::PokemonController < ApplicationController
  def index
    @pokemon = Pokemon.all
    render :index
  end

  def show
    @pokemon = Pokemon.includes(:items).find_by(id: params[:id])
    render :show
  end

  def create
    @pokemon = Pokemon.new(pokemon_params)

    if @pokemon.save
      render :show
    else
      render json: @pokemon.errors.full_messages, status: 422
    end

  end

  def update
  end

  def destroy
  end

  private
  def pokemon_params
    params.require(:pokemon).permit(
      :name,
      :attack,
      :defense,
      :poke_type,
      :image_url,
      moves: []
    )
  end
end
