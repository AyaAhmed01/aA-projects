class ArtworksController < ApplicationController
    def index
        user = User.find(params[:user_id])
        render json: [user.artworks, user.shared_artworks] 
    end

    def show 
        render json: ArtWork.find(params[:id])
    end

    def create
        artwork = ArtWork.new(artwork_params)
        if artwork.save
            render json: artwork
        else
            render json: artwork.errors.full_messages, status: :unprocessable_entity
        end
    end

    def update
        artwork = ArtWork.find(params[:id])
        if artwork.update(artwork_params)
            render json: artwork
        else
            render json: artwork.errors.full_messages, status: :unprocessable_entity
        end
    end

    def destroy
        artwork = ArtWork.find(params[:id])
        artwork.destroy
        render json: artwork 
    end

    private
    def artwork_params
        params.require(:artwork).permit(:title, :artist_id, :image_url)
    end
end