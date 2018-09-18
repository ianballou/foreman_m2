module ForemanM2
  module NicOrchestrationExtensions
    extend ActiveSupport::Concern

    included do
      # execute callbacks
      delegate :hybrid_build?, :to => :host
    end

    # create or overwrite instance methods...
    
    # def hybrid_build?
    #  self.provision_method == 'hybrid'
    # end

    def tftp_ready?
      # host.managed? and managed? should always come first so that 
      # orchestration doesn't
      # even get tested for such objects
      (host.nil? || host.managed?) && 
        managed && provision? && 
        (host.operatingsystem && host.pxe_loader.present?) && 
        (pxe_build? || host.hybrid_build?) && SETTINGS[:unattended]
    end
    
    def generate_pxe_template(kind)
      # this is the only place we generate a template not via a web request
      # therefore some workaround is required to "render" the template.

      # If hybrid building, do not generate the template variables
      @kernel = ''
      @initrd = ''
      @mediapath = ''
      @xen = ''
      unless host.hybrid_build?
        @kernel = host.operatingsystem.kernel(host.arch)
        @initrd = host.operatingsystem.initrd(host.arch)
        if host.operatingsystem.respond_to?(:mediumpath)
          @mediapath = host.operatingsystem.mediumpath(host)
        end
      end

      # Xen requires additional boot files.
      if host.operatingsystem.respond_to?(:xen)
        @xen = host.operatingsystem.xen(host.arch)
      end

      # work around for ensuring that people can use @host 
      # as well, as tftp templates were usually confusing.
      @host = self.host

      return build_pxe_render(kind) if build?
      default_pxe_render(kind)
    end

    def queue_tftp_create
      host.operatingsystem.template_kinds.each do |kind|
        queue.create(:name => _('Deploy TFTP %{kind} config for %{host}') % 
                     { :kind => kind, :host => self }, :priority => 20,
                     :action => [self, :setTFTP, kind])
      end
      return unless build
      # Download files if using media
      unless host.hybrid_build?
        queue.create(:name => _('Fetch TFTP boot files for %s') % self, 
                     :priority => 25, :action => [self, :setTFTPBootFiles])
      end
    end

    module ClassMethods
      # create or overwrite class methods...
      def class_method_name; end
    end
  end
end
