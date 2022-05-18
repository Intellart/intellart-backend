class Api::V1::ScienceDirectController < ApplicationController
  require 'dotenv/load'
  require 'elsevier_api'
  require 'uri'
  after_action :refresh_jwt

  API_KEY = ENV.fetch('SCIENCE_DIRECT_API_KEY')
  @conn = ElsevierApi::Connection.new(API_KEY)

  # GET /sd_search/scopus
  def search_scopus
    response = HTTParty.get(scopus_search_url)
    # not working as it should
    # response = @conn.retrieve_response(scopus_search_url)
    render json: response, status: :ok and return unless response.code != 200

    render json: response.body, status: :unprocessable_entity
  end

  # ACCESS DENIED
  # GET /sd_search/scopus/author
  def search_scopus_author
    response = HTTParty.get(scopus_author_search_url)
    render json: response, status: :ok and return unless response.code != 200

    render json: response.body, status: :unprocessable_entity
  end

  # ACCESS DENIED
  # GET /sd_search/scopus/affiliation
  def search_scopus_affiliation
    response = HTTParty.get(scopus_affiliation_search_url)
    render json: response, status: :ok and return unless response.code != 200

    render json: response.body, status: :unprocessable_entity
  end

  # ACCESS DENIED
  def authenticate
    url = 'https://api.elsevier.com/authenticate/'

    response = request.get(url)
    puts response
  end

  private

  def scopus_affiliation_search_url
    "https://api.elsevier.com/content/search/affiliation?apiKey=#{API_KEY}&query=#{search_params[:query]}"
  end

  def scopus_author_search_url
    "https://api.elsevier.com/content/search/author?apiKey=#{API_KEY}&query=#{search_params[:query]}"
  end

  def scopus_search_url
    url = URI('https://api.elsevier.com/content/search/scopus')
    params = { apiKey: API_KEY }.merge(search_params)
    url.query = URI.encode_www_form(params)
    url
  end

  def search_params
    params[:query] = CGI.escape(params[:query])
    params.permit(
      :query, :field, :date, :start, :count, :sort, :suppressNavLinks, :content, :subj, :alias, :facets
    )
  end
end
