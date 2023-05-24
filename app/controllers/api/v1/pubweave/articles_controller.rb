module Api
  module V1
    module Pubweave
      class ArticlesController < ApplicationController
        helper ArticlesParamsHelper

        before_action :set_article, except: [:index, :create, :index_by_user, :index_by_status]
        before_action :authenticate_api_user!, except: [:index, :show, :index_by_user, :index_by_status]
        before_action :deny_published_article_update, only: [:update]
        after_action :refresh_jwt, only: [:create, :update, :destroy]
        before_action :require_owner, only: [:update, :destroy]
        before_action :authenticate_domain, except: [:index, :show, :index_by_user, :index_by_status]
        before_action :authenticate_api_admin!, only: [:accept_publishing, :reject_publishing]

        rescue_from ActiveRecord::RecordNotFound do
          render_json_error :not_found, :article_not_found
        end

        # GET api/v1/pubweave/articles/
        def index
          articles = if params[:article]&.keys&.include? 'user_id'
                       Article.where(author_id: article_params[:user_id])
                     elsif params[:article]&.keys&.include? 'status'
                       Article.where(status: article_params[:status])
                     else
                       Article.all
                     end
          render json: articles, status: :ok
        end

        # GET api/v1/pubweave/articles/:id
        def show
          render json: @article, status: :ok
        end

        # POST api/v1/pubweave/articles/
        def create
          @article = Article.new(article_params)
          render_json_validation_error(@article) and return unless @article.save

          render json: @article, status: :created
        end

        # POST api/v1/pubweave/articles/:id/add_tag/
        def add_tag
          tag = Tag.find(params[:tag_id])
          @article.tags << tag
          render json: @article
        rescue StandardError
          render json: :unprocessable_entity
        end

        # PUT/PATCH api/v1/pubweave/articles/:id/remove_tag/
        def remove_tag
          tag = @article.tags.find(params[:tag_id])
          @article.tags.delete(tag)
          render json: @article
        rescue StandardError
          render json: :unprocessable_entity
        end

        # POST api/v1/pubweave/articles/:id/like/
        def like
          @article.rate!(@current_user, :like)
          render json: @article, status: :ok
        rescue StandardError
          render json: @article.errors, status: :unprocessable_entity
        end

        # POST api/v1/pubweave/articles/:id/dislike/
        def dislike
          @article.rate!(@current_user, :dislike)
          render json: @article, status: :ok
        rescue StandardError
          render json: @article.errors, status: :unprocessable_entity
        end

        # PUT/PATCH api/v1/pubweave/articles/:id
        def update
          if article_update_params.key?(:content)
            section_params = JSON.parse(article_update_params[:content].to_json)
            article_update_params[:content] = section_params.first(2) # keep just the time and version
            section_params['blocks'].each do |block|
              block['article_id'] = @article.id
              block['collaborator_id'] = @current_user.id
              if (section = Section.find_by(id: block['id'])).present?
                section.update!(block)
              else
                Section.create!(block)
              end
            end
          end
          article_update_params[:content] = JSON.parse(article_update_params[:content].to_json) if article_update_params.key?(:content)
          render_json_validation_error(@article) and return unless @article.update(article_update_params)

          render json: @article, status: :ok
        end

        # DELETE api/v1/pubweave/articles/:id
        def destroy
          render json: @article.id, status: :ok if @article.destroy
        end

        # PUT api/v1/pubweave/articles/:id/request_publishing
        def request_publishing
          @article.request_publishing!
          render json: @article, status: :ok if @article.requested?
        end

        # PUT api/v1/pubweave/articles/:id/accept_publishing
        def accept_publishing
          @article.accept_publishing!
          render json: @article, status: :ok if @article.published?
        end

        # PUT api/v1/pubweave/articles/:id/reject_publishing
        def reject_publishing
          @article.reject_publishing!
          render json: @article, status: :ok if @article.rejected?
        end

        private

        def deny_published_article_update
          render json: { message: 'You can not edit a published article.' } and return if @article.status == 'published'
        end

        def require_owner
          head :unauthorized unless @current_user.id == @article.author_id || @current_user.super?
        end

        def set_article
          @article = Article.find(params[:id])
        end

        def content_params
          [:time, :version,
           { blocks: [:id, :type,
                      { data: [helpers.paragraph_and_heading_params,
                               helpers.math_and_html_params,
                               helpers.table_params,
                               helpers.list_params,
                               helpers.checklist_params,
                               helpers.warning_params,
                               helpers.code_params,
                               helpers.link_params,
                               helpers.image_params,
                               helpers.quote_params,
                               helpers.all_arrays_in_params].flatten }] }]
        end

        def permit_table_data(whitelist)
          return unless whitelist[:content].present?

          whitelist[:content][:blocks].each_with_index do |block, index|
            block[:data][:content] = params[:article][:content][:blocks][index][:data][:content] if block[:type] == 'table'
          end
        end

        def article_params
          params.require(:article).permit(:author_id, :title, :subtitle, :description, :status, :image, :star, :category_id, :tag_id,
                                          content: content_params).tap { |whitelist| permit_table_data(whitelist) }
        end

        def article_update_params
          params.require(:article).permit(:title, :subtitle, :likes, :description, :status, :image, :star, :category_id, :tag_id,
                                          content: content_params).tap { |whitelist| permit_table_data(whitelist) }
          # We are using tap because as of now Rails' strong params still don't permit an array of arrays
        end
      end
    end
  end
end
