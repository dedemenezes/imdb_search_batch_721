class MoviesController < ApplicationController
  def index
    if params[:query].blank?
      @movies = Movie.all
    else
      # @movies = Movie.where(title: params[:query])
      # @movies = Movie.where('title ILIKE ?', params[:query])
      # sql_query = 'title ILIKE :query OR synopsis ILIKE :query'

      # sql_query = "\
      #   title iLIKE :query \
      #   OR synopsis iLIKE :query \
      #   OR directors.first_name iLIKE :query \
      #   OR directors.last_name iLIKE :query
      # "

      # PG Full-text Search
      # LIKE -> Busca por caracteres em ORDEM!
      # dog
      # dogs dogville

      # FULL TEXT -> Busca através de indexação das palavras
      # JUMP
      # jumping, jumps, jumped

      # sql_query = " \
      #   movies.title @@ :query \
      #   OR movies.synopsis @@ :query \
      #   OR directors.first_name @@ :query \
      #   OR directors.last_name @@ :query \
      # "

      # @movies = Movie.joins(:director).where(sql_query, query: "%#{params[:query]}%")
      # @movies = Movie.search_by_title_and_synopsis(params[:query])
      # @movies = Movie.global_search(params[:query])
      @movies = PgSearch.multisearch(params[:query])
    end
    # raise
  end
end
