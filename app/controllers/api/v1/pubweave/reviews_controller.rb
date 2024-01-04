module Api
  module V1
    module Pubweave
      class ReviewsController < ApplicationController
        def show
          review = Review.where(id: params[:id])
          render json: review, include: :user_reviews
        end
        
      end
    end
  end
end
