
class BetterTogether::Post < ApplicationRecord
  include FriendlySlug
  slugged :title

  translates :title
  translates :content, type: :text
end
