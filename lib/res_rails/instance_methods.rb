module ResRails::InstanceMethods
  # name of the singular resource eg: 'user'
  def resource_name
    controller_name.singularize
  end

  # name of the resource collection eg: 'users'
  def resources_name
    controller_name
  end

  # eg: 'User'
  def resource_class_name
    resource_name.classify
  end

  #  eg: User klass
  def resource_class
    resource_class_name.constantize
  end
end