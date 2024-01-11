module Api
  module V1
    module Pubweave
      class ReviewsController < ApplicationController
        before_action :set_review, only: [:show, :destroy]

        def index
          article_id = params[:article_id]
          @reviews = if article_id.present?
                       Review.where(article_id: article_id)
                     else
                       Review.all
                     end
          render json: @reviews, each_serializer: ReviewSerializer
        end

        def show
          render json: @review
        end

        def create
          @review = Review.new(review_params.except(:user_ids))
          ActiveRecord::Base.transaction do
            if @review.save
              user_ids = review_params[:user_ids]
              user_ids.each do |user_id|
                if User.find(user_id)
                  user_review = UserReview.new(user_id: user_id, review_id: @review.id)
                  user_review.save
                end
              end

              @review.article.reviewing! if @review.article.draft? || @review.article.published? # TODO: Raise error if article is not in the draft or published state
              render json: @review, status: :ok
            else
              render json: @review.errors, status: :unprocessable_entity
            end
          end
        end

        def destroy
          ActiveRecord::Base.transaction do
            if @review.destroy
              render json: { id: params[:id] }
            else
              render json: { error: 'Failed to delete review' }, status: :unprocessable_entity
            end
          end
        end

        private

        def set_review
          @review = Review.find(params[:id])
        end

        def review_params
          params.require(:review).permit(:deadline, :article_id, :amount, user_ids: [])
        end
      end
    end
  end
end
