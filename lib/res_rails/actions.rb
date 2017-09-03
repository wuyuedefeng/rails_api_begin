module ResRails
  module Actions
    include InstanceMethods
    def index
      self.resources = find_resources
    end

    def show
      self.resource = find_resource
    end

    def create
      form = "#{resource_class_name}Form::Create".constantize.new(resource_class.new)
      if form.validate(params) && form.save
        render json: { message: :successfully_create }, status: 200
      else
        render json: { message: form.errors.full_messages.first }, status: 422
      end
    end

    def update
      form = "#{resource_class_name}Form::Update".constantize.new(resource_class.find(params[:id]))
      if form.validate(params) && form.save
        render json: { message: :successfully_create }, status: 200
      else
        render json: { message: form.errors.full_messages.first }, status: 422
      end
    end

    def destroy
      self.resource = destroy_resource
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