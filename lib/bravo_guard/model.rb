module BravoGuard
  module Model
    extend ActiveSupport::Concern


    included do
      attr_accessor :actor
      include ObjectMethods
    end


  end
end


# railtie hooks this into AR::Base and BravoModel
module BravoGuard::Model::Hooks
  def acts_as_guarded
    include BravoGuard::Model
  end
end


# nodoc
module BravoGuard::Model::ClassMethods



  # nodoc
  def permission(*keys, &block)
    method_name = [:allows, keys].flatten.join('_') + '?'
    define_method method_name, &block
  end


end



# ObjectMethods to avoid deprecation warnings on InstanceMethods
module BravoGuard::Model::ObjectMethods



  # nodoc
  def allows?(actor, *permissions)
    begin
      permission = permissions.join('_')
      method_name = [:allows, permission_name(permission)].join('_') + '?'
      self.actor = actor
      send method_name
    rescue BravoGuard::PermissionDenied
      return false
    rescue BravoGuard::PermissionGranted
      return true
    ensure
      self.actor = nil
    end
  end



  # shorthand for 'return false'. allows?() will catch this and return false
  def no!
    raise BravoGuard::PermissionDenied
  end


  # see no!()
  def yes!
    raise BravoGuard::PermissionGranted
  end


  # nodoc
  def permission_name(permission)
    case permission
      when 'new' then :create
      when 'edit' then :update
      when 'delete' then :destroy
      when 'show' then :read
      when 'index' then :list
      else permission.to_s.to_sym
    end
  end


end
