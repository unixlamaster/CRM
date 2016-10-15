# Load the rails application
require File.expand_path('../application', __FILE__)
require 'ipaddr'
#Encoding.default_external = Encoding::UTF_8
#Encoding.default_internal = Encoding::UTF_8
Encoding.default_external = 'utf-8'
Encoding.default_internal = 'utf-8'
# Initialize the rails application
CRMRor::Application.initialize!

