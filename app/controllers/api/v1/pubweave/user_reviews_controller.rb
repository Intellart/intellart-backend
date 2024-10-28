module Api
  module V1
    module Pubweave
      class UserReviewsController < ApplicationController
        before_action :set_user_review

        # PUT api/v1/pubweave/user_reviews/:id/accept_review
        def accept_review
          @user_review.accept_review!
          render json: @user_review, status: :ok if @user_review.accepted?
        end

        # PUT api/v1/pubweave/user_reviews/:id/reject_review
        def reject_review
          @user_review.reject_review!
          render json: @user_review, status: :ok if @user_review.rejected?
        end

        private

        def set_user_review
          @user_review = UserReview.find(params[:id])
        end
      end
    end
  end
end
