module ForemanM2
  module ImagesHelperExtensions
    extend ActiveSupport::Concern

    included do
      # execute callbacks
    end

    # create or overwrite instance methods...
    def image_field(f, opts = {})
      return if (@compute_resource.capabilities & %i[image hybrid]).empty?
      images = @compute_resource.available_images
      if images.any?
        images.each { |image| image.name = image.id if image.name.nil? }
        select_f f, :uuid, images.to_a.sort_by { |image| image.name.downcase },
                 :id, :name, {}, :label => _('Image')
      else
        text_f f, :uuid, :label => opts[:label] || 
          _('Image ID'), :help_inline => opts[:help_inline] || 
          _('Image ID as provided by the compute resource, e.g. ami-..')
      end
    end
  end
end
