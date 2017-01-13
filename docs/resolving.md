# Local resolving

## Linux

### Ubuntu and Ubuntu based (16+)

    echo "address=/dev/127.0.0.1" | sudo tee /etc/NetworkManager/dnsmasq.d/dev-tld
    echo "address=/loc/127.0.0.1" | sudo tee /etc/NetworkManager/dnsmasq.d/loc-tld

    sudo service network-manager restart

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
