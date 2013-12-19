class CommentAuthorizer < ApplicationAuthorizer

  def self.creatable_by?(user, options = {})
    raise ArgumentError unless options[:for].present?
    parking = options[:for]
    parking.published? && parking.clients.exists?(id: user.id) && parking.comments.where(commenter: user).none?
  end
end
