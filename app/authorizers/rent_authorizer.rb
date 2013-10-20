class RentAuthorizer < ApplicationAuthorizer

  def self.readable_by?(user)
    true
  end

  def creatable_by?(user)
    user.parkings.include?(resource.parking)
  end

  def updatable_by?(user)
    resource.user == user
  end

  def deletable_by?(user)
    resource.user == user
  end
end
