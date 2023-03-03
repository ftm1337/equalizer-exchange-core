# Equalizer.Exchange - Core

## `v1.4.0`
This new version includes a lot of changes, especially to the way in which Trade Fees is distributed to the Voters.

### Implementations
| Smart Contract	| Implementation Smart Contract Address																						| Proxy Smart Contract Address																								|
|	----			|	----																													|	----																													|
| BribeFactory		| [`0x2C9C4cDd76F0FF50dBDd6931b97f1c4152fDFD1B`](https://ftmscan.com/address/0x2C9C4cDd76F0FF50dBDd6931b97f1c4152fDFD1B)	|	[`0x616174415fD648796c3428c4d55a5Fc66b79e4A3`](https://ftmscan.com/address/0x616174415fD648796c3428c4d55a5Fc66b79e4A3)	|
| GaugeFactory		| [`0x908B610208DCe86a7EB9f82055e9571d366D2ae1`](https://ftmscan.com/address/0x908B610208DCe86a7EB9f82055e9571d366D2ae1)	|	[`0x2E18C05446A55ab5856D211387f2E55ecDDD302b`](https://ftmscan.com/address/0x2E18C05446A55ab5856D211387f2E55ecDDD302b)	|
| Voter				| [`0xFE363d3DE8a0beA47cC7d7f5c096D3852AdbC396`](https://ftmscan.com/address/0xFE363d3DE8a0beA47cC7d7f5c096D3852AdbC396)	|	[`0xC1c7B3d94C8F0F6eC4c8F8D9bFc412f6BD110473`](https://ftmscan.com/address/0xC1c7B3d94C8F0F6eC4c8F8D9bFc412f6BD110473)	|


----


# Gameplan
Order of executing each step is important.

## Basics
### 3-4 March

- [ ] Deploy v2.Implementations
- [ ] Deploy v2.Proxies
- [ ] Initialize v2.voter
- [ ] Add Whitelist tokens on v2.voter
- [ ] Add Gaugeable tokens on v2.voter
- [ ] Create new Gauges on v2.voter
- [ ] TEST deposits/withdrawals from v2.Gauges
- [ ] TEST notification of bribes from v2.Gauges.deposit/widthdraw/claim
- [ ] TEST overriding notification of bribes to v2.Gauges.feeTaker
- [ ] TEST reward distribution
	- [ ] TEST Notify 0.01 EQUAL rewards to gauges
	- [ ] TEST deposits/withdrawals from v2.Gauges
	- [ ] TEST notification of bribes from v2.Gauges.deposit/widthdraw/claim
	- [ ] TEST overriding notification of bribes to v2.Gauges.feeTaker

## Review
### 3-7 March

- [ ] Get GamePlan reviewed by Peer 1
- [ ] Get GamePlan reviewed by Peer 2
- [ ] Get GamePlan reviewed by Peer 3
- [ ] Get GamePlan reviewed by Peer 4
- [ ] Get GamePlan reviewed by Peer 5
- [ ] Get Contracts reviewed by Peer 1
- [ ] Get Contracts reviewed by Peer 2
- [ ] Get Contracts reviewed by Peer 3


## Preparation
### 8 March, Wednesday

- [ ] Re-create ALL old (v1) gauges using new Voter (v2).

- [ ] Each team member should create 30 Special NFTs with 0.01 EQUAL max Locked
	- [ ] Each team member should vote for 10 different gauges with each NFT
	- [ ] Make sure to cover each & every pool with 10% votes of a NFT (10 pools x 15 NFTs)
	- [ ] Make sure votes are in before 8 March ends.
- [ ] Upgrade v1.Voter
	- [ ] Block new votes from 9 March 12 am
	- [ ] Introduce ResetOverride function
- [ ] Upgrade v1.VENFT
	- [ ] Introduce oldVoter variable: To allow attach/detach calls from v1.Gauges (oldVoter is still 0x00. Dont change yet)
	- [ ] Introduce retireTime variable: To make calls to distribute have no effect after retireTime
	- [ ] Introduce hotLoad function:
		- To load new Voter address into Venft contract (Dont call hotLoad yet)
		- To set oldVoter variable (Dont call hotLoad yet)
		- To set retireTime as time of hotLoading (Dont call hotLoad yet)
- [ ] Upgrade v1.Minter
	- [ ] Introduce hotLoad function: To load new Voter address into Minter contract (Dont call hotLoad yet)


## Core Switch
### 9 March, Thursday

- [ ] Flip the epoch (v1.minter.update_period)
- [ ] Distribute EQUAL emissions to all gauges (Make sure ALL gauges get as some rely on late friday distributions)
- [ ] Start resetting everyone's votes via v1.voter.resetOverride (dont reset the 20 new special nfts held by each team member)
- [ ] Again, make sure each & everyone's votes have been reset. Tally with v1.VENFT.voted(<id>).
- [ ] Call hotload on v1.Minter && Call hotload on v1.VENFT (TOGETHER!)
	- [ ] TEST voting using old v1.Voter.vote (MUST FAIL)
	- [ ] TEST voting using new v2.Voter.vote (MUST WORK)
	- [ ] TEST deposits via old v1.Gauges (MUST WORK)
	- [ ] TEST deposits via new v2.Gauges (MUST WORK)
	- [ ] TEST Each team member should vote for 10 different gauges with each NFT (MUST WORK)
	- [ ] TEST Make sure to cover each & every pool with 10% votes of a NFT (10 pools x 15 NFTs)
- [ ] TEST Wait some time, and then call v2.Gauges.deposit/withdraw (MUST WORK)
	- [ ] TEST if bribes are added to the v2.Gauges (MUST WORK)

## Final Announcement
### 15 March, Wednesday

- [ ] Ask Liquidity Providers to start moving to new Gauges
> *Maybe provide some pre-v2 incentives for v2.. reduce previous emission and add it here to v2? NOTE: if incentives are added, the tradeFees from such gauges would be sent to bribes, but at this point nobody can vote.. consider setting up an interim feeTaker meanwhile.*

## Migration
### 16 March, Thursday

- [ ] Flip the epoch using v1.minter.update_period (MUST WORK)
- [ ] Distribute EQUAL emissions to ALL gauges (MUST WORK)
- [ ] TEST deposits via old v1.Gauges (MUST WORK)
- [ ] TEST if bribes are added to the v2.Gauges (MUST WORK)
- [ ] TEST voting using new v2.Voter.vote (MUST WORK)
- [ ] TEST Claim EQUAL Gauge emissions via v2.Gauges.getReward(<0xEqualAddress>) (MUST WORK)

## Aftermath
### 17 March - Future

- [ ] Claim old internal & external Bribes from v1 using the Special 30 team veNFTs
	- [ ] Send these to treasury (PoL?)