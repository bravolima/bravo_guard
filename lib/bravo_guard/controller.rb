module BravoGuard::Controller


  # nodoc
  def authorise!(options={})
    return if authoriser.allows?(current_user, *permission)
    err = authoriser.inspect
    raise BravoGuard::PermissionDenied, err
  end


  # nodoc
  def authoriser
    return resource_class.new if action_name == 'index'
    build_resource if ['new', 'create'].include?(action_name)
    resource
  end


  # nodoc
  def permission
    action_name
  end


end
