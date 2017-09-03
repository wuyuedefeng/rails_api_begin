module ResRails
  module Actions
    include InstanceMethods
    def index
      @resources = find_resources
    end

    def show
      @resource = find_resource
    end

    def create &block
      form = "#{resource_class_name}Form::Create".constantize.new(resource_class.new)
      if form.validate(params) && form.save
        @resource = form.model
        if block_given?
          yield @resource
        else
          render json: { message: :successfully_create }, status: 200
        end
      else
        render json: { message: form.errors.full_messages.first }, status: 422
      end
    end

    def update &block
      form = "#{resource_class_name}Form::Update".constantize.new(resource_class.find(params[:id]))
      if form.validate(params) && form.save
        @resource = form.model
        if block_given?
          yield @resource
        else
          render json: { message: :successfully_create }, status: 200
        end
      else
        render json: { message: form.errors.full_messages.first }, status: 422
      end
    end

    def destroy
      @resource = destroy_resource
    end

    protected

    def find_resources
      resource_class.all
    end

    def find_resource(id = nil)
      id ||= respond_to?(:params) && params.is_a?(ActionController::Parameters) && params[:id]
      resource_class.find id
    end

    def destroy_resource(id = nil)
      id ||= respond_to?(:params) && params.is_a?(ActionController::Parameters) && params[:id]
      resource_class.destroy id
    end
  end
end