class Comment < ActiveRecord::Base
  include Authority::Abilities
  acts_as_comment
end
