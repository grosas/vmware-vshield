
require File.join(provider_path, 'vshield')

# Role Management 
# http://www.vmware.com/pdf/vshield_51_api.pdf Pg. 28
# Adding a user is not dc

Puppet::Type.type(:vshield_user).provide(:default, :parent => Puppet::Provider::Vshield) do
  @doc = 'Manages vShield user configuration.'

  def exists?
    results = ensure_array( nested_value(get("/api/2.0/services/usermgmt/users/vsm"), ['user', 'userInfo']) )
    # If there's a single application the result is a hash, while multiple results in an array.
    @userInfo = results.find {|userInfo| userInfo['name'] == resource[:name]}
  end

  def create
    data = {
      :name                           => resource[:name],
      :isEnabled 		      => true,
      :isGroup			      => false,
      :hasGlobalObjectAccess	      => true,
      :accessControlEntry	      => { :role => resource[:role],
      }
    }
    post("/api/2.0/services/usermgmt/user/local", {:userInfo => data} )
  end

  def destroy 
    Puppet.notice("feature not implemented")
  end

  def role
    @userInfo['accessControlEntry']['role']
  end

end
