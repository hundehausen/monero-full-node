# monero-full-node

docker image to run a monero full network node

# Usage

`docker run -tid --restart=always -v xmrchain:/home/monero/.bitmonero -p 18080:18080 -p 18081:18081 --name=monerod-mainnet hundehausen/monero-full-node`

## Release Notes
11.04.2021: v0.17.2.0

## Updating
Manual Way
```
docker stop monerod-mainnet
docker rm monerod-mainnet
docker pull hundehausen/monero-full-node
docker run -tid --restart=always -v xmrchain:/home/monero/.bitmonero -p 18080:18080 -p 18081:18081 --name=monerod-mainnet hundehausen/monero-full-node
```

Automatic way
https://github.com/v2tec/watchtower

# Donations

I am supporting this image in my spare time and would be very happy about some donations to keep this going. You can support me by sending some XMR to: `88EgBsoAZeWRCFfyw4ouZyTheJkD3G57nYoKSaE9gNLjExU2igevzp1WWmft5jUXqa2HG3ZTAcH8PHp2GPWuwcnoJGccziH`
