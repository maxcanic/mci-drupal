# Local resolving

In order to use domain names in browser for our container, we need to resolve those domains (`.loc` and `.dev`) to our local loopback address, `127.0.0.1`. We will base our discovery service on `dnsmasq` which is present on some systems and should be installed and configured on others.

Check documentation for your platform

- [Linux](#linux)
- [mMc](#mac)
- [Windows](#windows)

## Linux

### Ubuntu and Ubuntu based (16+)

This is tested and working also on Ubuntu 14 and 15.

Ubuntu is already using `dnasmasq` as part of its network services. We will not change it or disable, just add our resolving for `.loc` and `.dev`domains to `127.0.0.1`

    echo "address=/dev/127.0.0.1" | sudo tee /etc/NetworkManager/dnsmasq.d/dev-tld
    echo "address=/loc/127.0.0.1" | sudo tee /etc/NetworkManager/dnsmasq.d/loc-tld

    sudo service network-manager restart

Now all requests to `.loc` and `.dev` should resolve to `127.0.0.1`

    ping -c 1 the.very.strange-domain.dev.loc
    ping -c 1 even-more.very.strange-domain.loc.dev

## Mac

We need `brew` first

    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

Then we need `dnsmasq`

    brew install dnsmasq

Configuring `dnsmasq`

```
cp /usr/local/opt/dnsmasq/dnsmasq.conf.example /usr/local/etc/dnsmasq.conf
    
echo "
### local development ###
address=/dev/127.0.0.1
address=/loc/127.0.0.1
listen-address=127.0.0.1
" >> /usr/local/etc/dnsmasq.conf

sudo mkdir /etc/resolver
echo "nameserver 127.0.0.1" | sudo tee /etc/resolver/loc
echo "nameserver 127.0.0.1" | sudo tee /etc/resolver/dev
```

Starting `dnsmasq` service

    sudo cp /usr/local/Cellar/dnsmasq/2.57/uk.org.thekelleys.dnsmasq.plist /Library/LaunchDaemons
    sudo launchctl load -w /Library/LaunchDaemons/uk.org.thekelleys.dnsmasq.plist

Now all requests to `.loc` and `.dev` should resolve to `127.0.0.1`

    ping -c 1 the.very.strange-domain.dev.loc
    ping -c 1 even-more.very.strange-domain.loc.dev

## Windows
