class SearchController < ApplicationController
  def index
    @query_string = ''
    if params[:search].present? && params[:search][:query_string].present?
      @query_string = params[:search][:query_string]
      @documents = Document.search(@query_string)
    end
  end
end
