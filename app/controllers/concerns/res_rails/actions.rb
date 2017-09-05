module ResRails
  module Actions
    include InstanceMethods
    include Pagination
    include Search

    def index &block
      resources = find_resources
      if block_given?
        resources = yield(resources)
      end
      @resources = paginate resources
    end
    alias_method :res_index, :index
    # or in ruby > 2.2, child can call parent method use below method
    # method(:index).super_method.call

    def show
      @resource = find_resource
    end

    def create &block
      form = "#{resource_class_name}Form::#{action_name.classify}".constantize.new(resource_class.new)
      if form.validate(params) && form.save
        @resource = form.model
        if block_given?
          yield @resource
        else
          render json: { message: :successfully_create }, status: 200
        end
      else
        render json: { message: form.errors.full_messages.first || form.model.errors.full_messages.first }, status: 422
      end
    end

    def update &block
      form = "#{resource_class_name}Form::#{action_name.classify}".constantize.new(resource_class.find(params[:id]))
      if form.validate(params) && form.save
        @resource = form.model
        if block_given?
          yield @resource
        else
          render json: { message: :successfully_create }, status: 200
        end
      else
        render json: { message: form.errors.full_messages.first || form.model.errors.full_messages.first }, status: 422
      end
    end

    def destroy &block
      @resource = destroy_resource
      if block_given?
        yield @resource
      else
        render json: { message: :successfully_destroy }, status: 200
      end
    end

    protected

    def find_resources
      resource_class.ransack(prepare_search_condition).result
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