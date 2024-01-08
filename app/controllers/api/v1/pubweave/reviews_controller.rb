module Api
  module V1
    module Pubweave
      class ReviewsController < ApplicationController
        def show
          review = Review.where(article_id: params[:id])
          render json: review, include: { user_reviews: { serializer: UserReviewSerializer } }
        end

        def create
          review = Review.new(review_params.except(:user_ids))
          if review.save
            # create all user_reviews
            user_ids = review_params[:user_ids]
            user_ids.each do |user_id|
              user = User.find(user_id)
              user_review = UserReview.new(user_id: user_id, review_id: review.id)
              user_review.save
            end

            # switch article status to reviewing
            article = Article.find(review_params[:article_id])
            article.reviewing!

            render json: review, include: { user_reviews: { serializer: UserReviewSerializer } },  status: :created
          else
            render json: review.errors, status: :unprocessable_entity
          end
        end

        def destroy
          review = Review.find(params[:id])
          
          review.user_reviews.each do |user_review|
            user_review.destroy
          end

          

          if review.destroy
            render json: { id: params[:id] }
          else
            render json: { error: 'Failed to delete review' }, status: :unprocessable_entity
          end
        end

        private

        def review_params
          params.require(:review).permit(:deadline, :article_id, :amount, user_ids: [])
        end
      end
    end
  end
end
