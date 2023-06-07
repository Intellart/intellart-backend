module Api
  module V1
    module Pubweave
      class SectionsController < ApplicationController
        include Imageable

        before_action :authenticate_api_user!, except: [:index, :show, :index_by_user, :index_by_status]
        before_action :authenticate_domain, except: [:index, :show, :index_by_user, :index_by_status]
        before_action :authenticate_api_admin!, only: [:accept_publishing, :reject_publishing]
        before_action :set_paper_trail_whodunnit
        after_action :refresh_jwt, only: [:image_asset_save]

        # PUT/PATCH api/v1/pubweave/sections/:editor_section_id/image_asset_save
        def image_asset_save
          @section = Section.find(params[:editor_section_id])
          return unless params['section']['image'].present?

          Image.transaction do
            if @section.image.present?
              Cloudinary::Api.delete_resources(@section.image.public_id)
              @section.image.destroy
              @section.data.delete('file')
            end
            unless parameters['image'] == 'null'
              save_and_upload_image(params, @section)
              @section.data['file'] ||= {}
              @section.data['file']['url'] = @section.image.url if section.image.present?
            end
          end
          @section.save!

          render json: @section, status: :ok
        end

        # GET api/v1/pubweave/sections/:editor_section_id/version_data
        def version_data
          @section = Section.find(params[:editor_section_id])
          versions = @section.versions.to_a.map(&:reify).drop(1)
          render json: ActiveModelSerializers::SerializableResource.new(versions,
                                                                        each_serializer: SectionSerializer,
                                                                        fields: [:data, :version_number, :collaborator_id]).as_json
        end
      end
    end
  end
end
