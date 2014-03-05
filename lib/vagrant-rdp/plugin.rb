begin
  require "vagrant"
rescue LoadError
  raise "The Vagrant RDP plugin must be run within Vagrant."
end

module VagrantPlugins
  module RDP
    class Plugin < Vagrant.plugin("2")
      name "RDP"
      description <<-DESC
      With this plugin, you can connect to windows VM by remote desktop connection.
      DESC

      config(:rdp) do
        Config
      end

      command "rdp" do
        Command
      end
    end
  end
end
