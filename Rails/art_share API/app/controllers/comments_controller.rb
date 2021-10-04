class CommentsController < ApplicationController 
    def index 
        if comment_params[:author_id]
            author = User.find(comment_params[:author_id])
            comments = author.comments 
        else
            artwork = ArtWork.find(comment_params[:artwork_id])
            comments = artwork.comments 
        end
        render json: comments 
    end

    def create 
        comment = Comment.new(comment_params)
        if comment.save 
            render json: comment
        else
            render json: comment.errors.full_messages, status: :unprocessable-entity 
        end
    end

    def destroy
        comment = Comment.find(params[:id])
        comment.destroy
        render json: comment
    end

    private
    def comment_params
        self.params[:comment].permit(:author_id, :artwork_id, :body)
    end
end