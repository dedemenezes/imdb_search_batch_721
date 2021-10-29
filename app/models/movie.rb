class Movie < ApplicationRecord
  belongs_to :director

  # searchkick - method calling GEM used for elastic search

  ##########################
  ####### REAL DEAL! #######
  ####### PGSearch! ########
  ##########################

  include PgSearch::Model
  pg_search_scope :search_by_title_and_synopsis,
                  against: %i[title synopsis],
                  using: {
                    # @@
                    tsearch: { prefix: true } # <-- now `superman batm` will return something!
                  }

  pg_search_scope :global_search,
                  against: %i[title synopsis],
                  associated_against: {
                    director: %i[first_name last_name]
                  },
                  using: {
                    tsearch: { prefix: true }
                  }
  multisearchable against: %i[title synopsis]
end
