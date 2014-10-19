#!/usr/bin/env ruby

require 'vcloud-rest/connection'

begin
  gem "awesome_print"
rescue LoadError
  system("gem install awesome_print")
  Gem.clear_paths
end
require 'awesome_print'


host = 'https://roecloud001.sealsystems.local'
user = 'vagrant'
pass = 'MySecretPass' # this is not my password ;-)
org  = 'SS'
api  = '5.1'

puts "#################################################################"
puts "# vcloud-rest example"
puts "#"
puts "### Connect to vCloud"

### Connect to vCloud

connection = VCloudClient::Connection.new(host, user, pass, org, api)
connection.login

### Fetch a list of the organizations you have access to

puts "### Fetch and List Organizations"
orgs = connection.get_organizations
ap orgs

### Fetch and show an organization, COE is an example, you should replace it with your own organization
org = orgs.keys[0]

puts "### Fetch and Show fist Organization"
org = connection.get_organization(orgs[org])
ap org

### Fetch and show a vDC, OvDC-PAYG-Bronze-01 is an example, you should replace it with your own vDC

# puts "### Fetch and Show 'OvDC-PAYG-Bronze-01' vDC"
# vdc = connection.get_vdc(org[:vdcs]["OvDC-PAYG-Bronze-01"])
# ap vdc

# ### Fetch and show a Catalog, Vagrant is an example, you should replace it with your own Catalog

# puts "### Fetch and Show 'Vagrant' Catalog"
# cat = connection.get_catalog(org[:catalogs]["Vagrant"])
# ap cat

# ### Fetch and show a Catalog Item, precise32 is an example, you should replace it with your own Catalog Item

# puts "### Fetch info on Catalog Item 'precise32'"
# catitem = connection.get_catalog_item(cat[:items]["precise32"])
# ap catitem

# ### Fetch and show a vApp Template, precise32 is an example, you should replace it with your own vApp Template

# puts "### Show vApp Template 'precise32'"
# vapp = connection.get_vapp_template(catitem[:items]["precise32"])
# ap vapp

# ### Compose a vApp, you should replace the Org vDC with your own, as well as changing the VM to be used as source

# puts "### Compose a vApp in 'OvDC-PAYG-Bronze-01' using VM coming from 'precise32'"
# compose = connection.compose_vapp_from_vm(
# 	org[:vdcs]["OvDC-PAYG-Bronze-01"],
# 	"Composed vApp",
# 	"Composed vApp created with vcloud-rest Ruby Bindings",
# 	{
# 		"VM1" => vapp[:vms_hash]["precise32"][:id],
# 		"VM2" => vapp[:vms_hash]["precise32"][:id],
# 		"VM3" => vapp[:vms_hash]["precise32"][:id],
# 		"VM4" => vapp[:vms_hash]["precise32"][:id]
# 		},
# 	{
# 		:name => "test-network",
# 		:gateway => "192.168.0.253",
# 		:netmask => "255.255.255.0",
# 		:start_address => "192.168.0.1",
# 		:end_address => "192.168.0.100",
# 		:fence_mode => "natRouted",
# 		:ip_allocation_mode => "POOL",
# 		:parent_network =>  vdc[:networks]["Internet-NAT"],
# 		:enable_firewall => "false"
# 		})

# puts "### Wait until the Task is completed"
# wait = connection.wait_task_completion(compose[:task_id])

# ### Shows the vApp that has been composed with the previous action

# puts "### Details of the new vApp"
# newvapp = connection.get_vapp(compose[:vapp_id])
# ap newvapp

# ### Add another VM to the vApp just created

# puts "### Add another VM from 'precise32' in vApp 'Composed vApp'"
# task_id = connection.add_vm_to_vapp(newvapp, { :template_id => vapp[:vms_hash]["precise32"][:id], :vm_name => "VM5" }, { :name => "test-network", :ip_allocation_mode => "POOL" })
# connection.wait_task_completion(task_id)

# ### Show the vApp again so we can see the new VM in it
# newvapp = connection.get_vapp(newvapp[:id])
# ap newvapp

# ### Here we build an array with the needed info, be aware that vm_id != vapp_scoped_local_id

# puts "### Building Port Forwarding NAT Rules"
# j = 2222
# nat_rules = []
# newvapp[:vms_hash].each do |key, value|
# 	nat_rules << { :nat_external_port => j.to_s, :nat_internal_port => "22", :nat_protocol => "TCP", :vm_scoped_local_id => value[:vapp_scoped_local_id]}
# 	j += 1
# end
# newvapp[:vms_hash].each do |key, value|
# 	nat_rules << { :nat_external_port => j.to_s, :nat_internal_port => "873", :nat_protocol => "UDP", :vm_scoped_local_id => value[:vapp_scoped_local_id]}
# 	j += 1
# end
# ap nat_rules

# ### Here we apply the nat_rules to the vApp we just built

# puts "### Applying Port Forwarding NAT Rules"
# setrule = connection.set_vapp_port_forwarding_rules(
# 	compose[:vapp_id],
# 	"test-network",
# 	{
# 		:fence_mode => "natRouted",
# 		:parent_network => vdc[:networks]["Internet-NAT"],
# 		:nat_policy_type => "allowTraffic",
# 		:nat_rules => nat_rules
# 	})

# puts "### Wait until the Task is completed"
# wait = connection.wait_task_completion(setrule)

# ### After 4 minutes the vApp gets deleted, make sure to check the vCloud web UI to assess the creation.

# puts "### Waiting for 240 seconds before deleting the newly created vApp, check your vCloud web UI."
# sleep 240

# puts "### Deleting the vApp"
# delete = connection.delete_vapp(compose[:vapp_id])

# puts "### Wait until the Task is completed"
# wait = connection.wait_task_completion(delete)

# ### Upload an OVF to 'OvDC-PAYG-Bronze-01' 'Vagrant' catalog

# puts "### Upload vcloud_precise64.ovf to 'OvDC-PAYG-Bronze-01' 'Vagrant' catalog"
# upload = connection.upload_ovf(
# 	org[:vdcs]["OvDC-PAYG-Bronze-01"], 
# 	"precise64", 
# 	"Precise64 upload", 
# 	"dumpster/vcloud_precise64.ovf", 
# 	org[:catalogs]["Vagrant"], 
# 	{ 
# 		:progressbar_enable => true, 
# 		:retry_time => 20, 
# 		:chunksize => 5242880, 
# 		:progressbar_format => "%t |%w%i| %e", 
# 		:progressbar_length => 80,
# 		:send_manifest => false
# 	})

### Logout from vCloud Director
connection.logout
