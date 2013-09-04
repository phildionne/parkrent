class LicensePlateValidator < ActiveModel::EachValidator

  # Validates a license plate is valid
  #
  # @param record [ActiveRecord::Model]
  # @param attribute [Symbol]
  # @param value [String]
  def validate_each(record, attribute, value)
    value.squish! if value.respond_to?(:squish)

    formats = [
      /\A[a-zA-Z]\d{2} ?[a-zA-Z]{3}\z/,  # A00 ABC
      /\A[a-zA-Z]{3} ?\d{3}\z/,          # ABC 000
      /\A\d{3} ?[a-zA-Z]{3}\z/,          # 000 ABC
      /\A(c|C)(c|C|d|D) ?\d{3}\z/,       # CD 000 and CC 000
      /\A\d{3}[a-zA-Z]\d{3}\z/           # 000H000
    ]

    regex = Regexp.union(formats)

    unless value.present? && value.match(regex)
      record.errors[attribute] << (options[:message] || "is not a valid license plate")
    end
  end
end
