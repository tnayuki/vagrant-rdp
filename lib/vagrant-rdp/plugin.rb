begin
  require "vagrant"
rescue LoadError
  raise "The Vagrant AWS plugin must be run within Vagrant."
end

module VagrantPlugins
  module RDP
    class Plugin < Vagrant.plugin("2")
      name "RDP"
      description <<-DESC
      With this plugin, you can connect to windows VM by remote desktop connection.
      DESC

      command "rdp" do
        Command
      end
    end
  end
end
