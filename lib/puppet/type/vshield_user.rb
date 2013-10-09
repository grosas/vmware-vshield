# Copyright (C) 2013 VMware, Inc.
require 'pathname'
vmware_module = Puppet::Module.find('vmware_lib', Puppet[:environment].to_s)
require File.join vmware_module.path, 'lib/puppet/property/vmware'

Puppet::Type.newtype(:vshield_user) do
  @doc = 'Manage vShield Manager Users'

  ensurable

  newparam(:name, :namevar => true) do
    desc 'user name'
  end

  newproperty(:role, :array_matching => :all, :parent => Puppet::Property::VMware_Array ) do
    desc 'user role, this defines the user role'
    munge do |value|
      # Possible roles are super_user, vshield_admin, enterprise_admin, security_admin, and auditor
      value.to_s
    end
  end

end
