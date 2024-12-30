module Paginatable
  extend ActiveSupport::Concern

<<<<<<< HEAD
  MAX_PER_PAGE = 10
  DEFAULT_PAGE = 1

  included do
    scope :paginate, ->(page = DEFAULT_PAGE, length = MAX_PER_PAGE) do
      page = page > 0 ? page : DEFAULT_PAGE
      length = length > 0 ? length : MAX_PER_PAGE
=======
  DEFAULT_MAX_PER_PAGE = 10
  DEFAULT_PAGE = 1

  included do
    scope :paginate, ->(page, length) do
      page = page.present? && page > 0 ? page : DEFAULT_PAGE
      length = length.present? && length > 0 ? length : MAX_PER_PAGE
>>>>>>> 6ad46b8826e08838da68a791b6bfbe391807d51c
      starts_at = (page - 1) * length
      limit(length).offset(starts_at)
    end
  end
end
