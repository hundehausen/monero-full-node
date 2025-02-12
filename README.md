# monero-full-node

docker image to run a monero full node (pruned) on mainnet

# Usage

`docker run -tid --restart=always -v xmrchain:/home/monero/.bitmonero -p 18080:18080 -p 18081:18081 --name=monerod-mainnet hundehausen/monero-full-node`

## Release Notes
```
11.04.2021: v0.17.2.0
12.04.2021: added healthchecks and disabled zmq in monerod
01.09.2021: v0.17.2.3
07.12.2021: v0.17.3.0
01.04.2022: v0.17.3.2
20.07.2022: v0.18.0.0
11.08.2022: v0.18.1.0
20.09.2022: v0.18.1.1
03.10.2022: v0.18.1.2
01.03.2023: v0.18.2.0
10.04.2023: v0.18.2.2
10.10.2023: v0.18.3.1
```

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

I am supporting this image in my spare time and would be very happy about some donations to keep this going. You can support me by sending some XMR to: `89HEKdUFM2dJGDFLpV7CoLUW1Swux7iBMMCXMC5y3U2DihmrbYh6AEoanoHb8VPJrCDLTa9FJfooHdz1rGZH9L342TXwZh7`
