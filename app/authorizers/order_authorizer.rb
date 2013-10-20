class OrderAuthorizer < ApplicationAuthorizer

  def self.creatable_by?(user)
    true
  end

  def readable_by?(user)
    resource.user == user
  end

  def updatable_by?(user)
    resource.user == user
  end

  def deletable_by?(user)
    resource.user == user
  end
end
