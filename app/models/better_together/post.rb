
class BetterTogether::Post < ApplicationRecord
  include ::BetterTogether::FriendlySlug
  slugged :title

  translates :title
  translates :content, type: :text
end
