module EmptyForm
  extend ActiveSupport::Concern

  def check(params)
    errors = ""
    params.each do |name, value|
      if value == ""
        errors << name + " "
      end
    end
    if errors.empty?
      nil
    else
      errors
    end
  end
end