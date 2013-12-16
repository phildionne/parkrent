class Checkout
  include Associates

  associate :user, delegate: false
  associate :order, depends_on: :user
  associate :rent, depends_on: :user
  associate :vehicle, depends_on: :user
  # associate :payment
end
