module Api
  module V1
    module Pubweave
      class PreprintsController < ApplicationController
        before_action :set_preprint, except: [:index, :create, :index_by_status]
        before_action :authenticate_api_user!, except: [:index, :show, :index_by_user, :index_by_status]
        before_action :deny_published_preprint_update, only: [:update]
        after_action :refresh_jwt, only: [:create, :update, :destroy]
        # before_action :require_owner, only: [:update, :destroy]
        before_action :authenticate_domain, except: [:index, :show, :index_by_user, :index_by_status]
        before_action :authenticate_api_admin!, only: [:accept_publishing, :reject_publishing]

        rescue_from ActiveRecord::RecordNotFound do
          render_json_error :not_found, :preprint_not_found
        end

        # GET api/v1/pubweave/preprints/
        def index
          preprints = Preprint.all
          render json: preprints, status: :ok
        end

        # # GET api/v1/pubweave/user_preprints/:user_id
        # def index_by_user
        #   preprints = Preprint.all.where(user_id: preprint_params[:user_id])
        #   render json: preprints, status: :ok
        # end

        # GET api/v1/pubweave/status_preprints/:status
        def index_by_status
          preprints = Preprint.all.where(status: preprint_params[:status])
          render json: preprints, status: :ok
        end

        # GET api/v1/pubweave/preprints/:id
        def show
          render json: @preprint, status: :ok
        end

        # POST api/v1/pubweave/preprints/
        def create
          @preprint = Preprint.new(preprint_params)
          render_json_validation_error(@preprint) and return unless @preprint.save

          latest_version = @preprint.versions.last
          latest_version.whodunnit = @current_user
          render_json_validation_error(@preprint) and return unless latest_version.save

          @preprint_user = PreprintUser.new(preprint_id: @preprint.id, user_id: @current_user.id)
          render_json_validation_error(@preprint_user) and return unless @preprint_user.save

          render json: @preprint, status: :created
        end

        # # PUT/PATCH api/v1/pubweave/preprints/:id/like/
        # def like
        #   @preprint.likes += 1
        #   render_json_validation_error(@preprint) and return unless @preprint.save

        #   render json: @preprint, status: :ok
        # end

        # PUT/PATCH api/v1/pubweave/preprints/:id
        def update
          render_json_validation_error(@preprint) and return unless @preprint.update(preprint_update_params)

          new_user = !PreprintUser.find_by(preprint_id: @preprint.id, user_id: @current_user.id)

          if new_user
            @preprint_user = PreprintUser.new(preprint_id: @preprint.id, user_id: @current_user.id)
            render_json_validation_error(@preprint_user) and return unless @preprint_user.save
          end

          latest_version = @preprint.versions.last
          latest_version.whodunnit = @current_user
          render_json_validation_error(@preprint) and return unless latest_version.save

          render json: @preprint, status: :ok
        end

        # DELETE api/v1/pubweave/preprints/:id
        def destroy
          render json: @preprint.id, status: :ok if @preprint.destroy
        end

        # PUT api/v1/pubweave/preprints/:id/request_publishing
        def request_publishing
          @preprint.request_publishing!
          render json: @preprint, status: :ok if @preprint.requested?
        end

        # PUT api/v1/pubweave/preprints/:id/accept_publishing
        def accept_publishing
          @preprint.accept_publishing!
          render json: @preprint, status: :ok if @preprint.published?
        end

        # PUT api/v1/pubweave/preprints/:id/reject_publishing
        def reject_publishing
          @preprint.reject_publishing!
          render json: @preprint, status: :ok if @preprint.rejected?
        end

        private

        def deny_published_preprint_update
          render json: { message: 'You can not edit a published preprint.' } and return if @preprint.status == 'published'
        end

        # def require_owner
        #   head :unauthorized unless @current_user.id == @preprint.user_id || @current_user.super?
        # end

        def set_preprint
          @preprint = Preprint.find(params[:id])
        end

        def preprint_params
          params.require(:preprint).permit(:title, :subtitle, :content, :description, :status, :image, :star, :category_id)
        end

        def preprint_update_params
          params.require(:preprint).permit(:title, :subtitle, :content, :likes, :description, :status, :image, :star, :category_id)
        end
      end
    end
  end
end
