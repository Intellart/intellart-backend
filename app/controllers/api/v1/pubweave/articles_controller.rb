module Api
  module V1
    module Pubweave
      class ArticlesController < ApplicationController
        helper ArticlesParamsHelper

        include AssetHandler

        before_action :set_article, except: [:index, :create, :index_by_user, :index_by_status]
        before_action :authenticate_api_user!, except: [:index, :show, :index_by_user, :index_by_status]
        before_action :deny_published_article_update, only: [:update]
        after_action :refresh_jwt, only: [:create, :update, :destroy]
        before_action :require_owner, only: [:destroy]
        before_action :authenticate_domain, except: [:index, :show, :index_by_user, :index_by_status]
        before_action :authenticate_api_admin!, only: [:accept_publishing, :reject_publishing]
        before_action :set_paper_trail_whodunnit

        rescue_from ActiveRecord::RecordNotFound do
          render_json_error :not_found, :article_not_found
        end

        # GET api/v1/pubweave/articles/
        def index
          articles = if params[:article]&.keys&.include? 'user_id'
                       Article.where(author_id: article_params[:user_id]) + User.find(article_params[:user_id]).collaborations
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
          parameters = article_params
          if article_params['image'].present?
            parameters = article_params.except(:image)
            save_and_upload_image(article_params, @article)
          end
          @article = Article.new(parameters)
          render_json_validation_error(@article) and return unless @article.save

          render json: @article, status: :created
        end

        def add_collaborator
          @article.collaborators << User.find_by(email: article_params[:collaborator_email])
          render json: @article, status: :ok
        end

        # POST api/v1/pubweave/articles/:id/add_tag/
        def add_tag
          tag = Tag.find(article_params[:tag_id])
          @article.tags << tag
          render json: @article
        rescue StandardError
          render json: :unprocessable_entity
        end

        # PUT/PATCH api/v1/pubweave/articles/:id/remove_tag/
        def remove_tag
          tag = @article.tags.find(article_params[:tag_id])
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

        # PUT/PATCH api/v1/pubweave/articles/:id/convert/
        def convert
          if @article.blog_article?
            @article.convert_to_preprint!
          elsif @article.preprint?
            @article.convert_to_scientific_article!
          end

          render json: @article, status: :ok
        rescue StandardError
          render json: @article.errors, status: :unprocessable_entity
        end

        # PUT/PATCH api/v1/pubweave/articles/:id
        def update
          parameters = article_update_params
          if parameters['image'].present?
            img = Image.find_by!(url: parameters['image'])
            parameters = parameters.except(:image)
            
            @article.update!(image: img.dup)
            return render json: @article, status: :ok
          end
          if parameters.key?(:content)
            section_params = JSON.parse(parameters[:content].to_json)
            parameters[:content] = section_params.first(2) # keep just the time and version
            section_params['blocks'].each do |block|
              update_block(block, parameters)
            end
          end
          render_json_validation_error(@article) and return unless @article.update(parameters)

          render json: @article, status: :ok
        end

        # DELETE api/v1/pubweave/articles/:id
        def destroy
          render json: @article.id, status: :ok if @article.destroy
        end

        # PUT api/v1/pubweave/articles/:id/request_publishing
        def request_publishing
          @article.request_publishing!
          render json: @article, status: :ok # if @article.requested?
        end

        # # PUT api/v1/pubweave/articles/:id/accept_publishing
        # def accept_publishing
        #   @article.accept_publishing!
        #   render json: @article, status: :ok if @article.published?
        # end

        # # PUT api/v1/pubweave/articles/:id/reject_publishing
        # def reject_publishing
        #   @article.reject_publishing!
        #   render json: @article, status: :ok if @article.rejected?
        # end

        private

        def deny_published_article_update
          render json: { message: 'You cannot edit a published article.' }, status: :forbidden and return if @article.status == 'published' && !@current_user.is_a?(Admin)
        end

        def require_owner
          head :unauthorized unless @current_user.id == @article.author_id || @current_admin.super?
        end

        def set_article
          @article = Article.find(params[:id])
        end

        def update_block(block, parameters)
          block['article_id'] = @article.id
          block['collaborator_id'] = @current_user.id

          block['editor_section_id'] = block['id']
          block.delete('id')

          block['version_number'] = parameters['version_number'] if parameters.key?(:version_number)
          action = block['action']
          block.delete('action')

          if %w[updated moved].include?(action)
            # Unlock the previous section if it exists
            section = Section.find_by(collaborator_id: @current_user.id)
            section.unlock if section.present?
            
            # Update the section
            section = Section.find(block['editor_section_id'])
            section.update!(block)

            payload = SectionSerializer.new(section).to_h
            payload[:time] = @article.content.to_h['time'] if @article.content.present?
            section.broadcast("ArticleChannel-#{@article.id}", 'section', 'update', payload)
          elsif action == 'created'
            if block['type'] == 'image'
              img = Image.find_by(url: block["data"]["file"]["url"])
              if img.present?
                block["image"] = img
              end
            end
            section = Section.create!(block)
            section.lock(@current_user.id)
          elsif action == 'deleted'
            section = Section.find(block['editor_section_id'])
            if section.type == 'image' &&
               section.image.present? && 
               @article.image.present? &&
               section.image.url == @article.image.url
              @article.image = nil
              @article.save!
            end
            section.destroy!
          end
        end

        def content_params
          [:time, :version,
           { blocks: [:id, :type, :position, :action,
                      { data: [helpers.paragraph_and_heading_params,
                               helpers.math_and_html_params,
                               helpers.table_params,
                               helpers.list_params,
                               helpers.checklist_params,
                               helpers.warning_params,
                               helpers.code_params,
                               helpers.link_params,
                               helpers.image_params,
                               helpers.inline_image_params,
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
          params.require(:article).permit(:author_id, :title, :collaborator_email, :subtitle, :description, :status, :image, :star, :category_id, :tag_id, :version_number, :user_id,
                                          content: content_params).tap { |whitelist| permit_table_data(whitelist) }
        end

        def article_update_params
          params.require(:article).permit(:title, :subtitle, :likes, :description, :status, :image, :star, :category_id, :tag_id, :version_number,
                                          content: content_params).tap { |whitelist| permit_table_data(whitelist) }
          # We are using tap because as of now Rails' strong params still don't permit an array of arrays
        end
      end
    end
  end
end
