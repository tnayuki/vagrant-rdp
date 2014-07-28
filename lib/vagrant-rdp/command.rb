require 'optparse'
require 'tempfile'

module VagrantPlugins
  module RDP
    class Command < Vagrant.plugin(2, :command)
      def execute
        opts = OptionParser.new do |opts|
          opts.banner = "Usage: vagrant rdp [vm-name...]"

          opts.separator ""
        end

        argv = parse_options(opts)
        return -1 if !argv

        with_target_vms(argv) do |vm|
          @logger.info("Launching remote desktop session to: #{vm.name}")
          rdp_connect(vm)
        end

        return 0
      end

      def rdp_connect(vm)
        rdpport = nil
        vm.provider.driver.read_forwarded_ports.each do |_, _, hostport, guestport|
          rdpport = hostport if guestport == 3389
        end

        Tempfile.open('vagrant-rdp-shell-') do |tf|
          rdp_file = rdp_file(vm, rdpport)

          tf.puts <<EOS
open -a "/Applications/Remote Desktop Connection.app/Contents/MacOS/Remote Desktop Connection" "#{rdp_file}"
sleep 5 #HACK
rm "#{rdp_file}"
EOS
          tf.close

          # Spawn remote desktop and detach it so we can move on.
          pid = spawn("/bin/bash", tf.path)
          Process.detach(pid)
        end
      end

      def rdp_file(vm, rdpport)
        path = nil

        Tempfile.open([ "vagrant-rdp-", ".rdp" ], vm.data_dir) { |fp|
          path = fp.path
          fp.unlink
        }

        File.open(path, "w") { |io|
          io.puts <<EOF
screen mode id:i:0
desktopwidth:i:#{vm.config.rdp.width}
desktopheight:i:#{vm.config.rdp.height}
use multimon:i:1
session bpp:i:32
full address:s:localhost:#{rdpport}
audiomode:i:0
disable wallpaper:i:0
disable full window drag:i:0
disable menu anims:i:0
disable themes:i:0
alternate shell:s:
shell working directory:s:
authentication level:i:2
connect to console:i:0
gatewayusagemethod:i:0
disable cursor setting:i:0
allow font smoothing:i:1
allow desktop composition:i:1
bookmarktype:i:3
use redirection server name:i:0
EOF
        }

        path
      end
    end
  end
end
