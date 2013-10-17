# Copyright (C) 2013 VMware, Inc.
import 'data.pp'

transport { 'vshield':
  username => $vshield['username'],
  password => $vshield['password'],
  server   => $vshield['server'],
}

vshield_user { $user1['name']:
  ensure             => present,
  role               => $user1['role'],
  transport          => Transport['vshield'],
}
