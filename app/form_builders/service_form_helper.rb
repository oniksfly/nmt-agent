class ServiceFormHelper < ActionView::Helpers::FormBuilder
  def text_field(attribute, options = {})
    label(attribute) + super
  end
end