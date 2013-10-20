class ParkingAuthorizer < ApplicationAuthorizer

  def self.readable_by?(user)
    true
  end

  def self.creatable_by?(user)
    true
  end

  def readable_by?(user)
    resource.user == user || resource.published?
  end

  def updatable_by?(user)
    resource.user == user
  end

  def deletable_by?(user)
    resource.user == user
  end
end
