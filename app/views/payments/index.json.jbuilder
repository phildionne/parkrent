json.array!(@payments) do |payment|
  json.extract! payment, :amount, :type
  json.url payment_url(payment, format: :json)
end
