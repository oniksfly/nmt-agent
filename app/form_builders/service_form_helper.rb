include ActionView::Helpers::TagHelper

class ServiceFormHelper < ActionView::Helpers::FormBuilder
  def text_field(attribute, options = {})
    validation_errors = false

    options[:class] = '' if options[:class].blank?

    if @options[:service_object].present?
      validation_status = @options[:service_object].form_attribute_valid?(attribute)

      if validation_status === false
        validation_errors = true
        options[:class] = options[:class] + ' is-invalid'
      end
    end



    if validation_errors
      super + content_tag(:div, @options[:service_object].errors[attribute], class: 'invalid-feedback')
    else
      super
    end
  end
end