require "vagrant"

module VagrantPlugins
  module RDP
    class Config < Vagrant.plugin("2", :config)
      attr_accessor :width
      attr_accessor :height

      def initialize
        @width  = UNSET_VALUE
        @height = UNSET_VALUE
        @multimon = UNSET_VALUE
      end

      def validate(machine)
        errors = []

        { "RDP" => errors }
      end

      def finalize!
        @width  = 1024 if @width  == UNSET_VALUE
        @height = 768  if @height == UNSET_VALUE
        @multimon = 1 if @multimon == UNSET_VALUE
      end
    end
  end
end
