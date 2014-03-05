# vagrant-rdp

With this plugin, you can connect to windows VM by remote desktop connection.

# Installation

```
$ vagrant plugin install vagrant-rdp
```

## Usage

Add the following to your Vagrantfile of Windows guest

```
config.vm.network :forwarded_port, guest: 3389, host: 33389, auto_correct: true
```

Now you can connect to windows guest by following command

```
$ vagrant rdp
```

## Contributing

1. Fork it ( http://github.com/<my-github-username>/vagrant-rdp/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
