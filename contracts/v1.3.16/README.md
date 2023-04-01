# Equalizer.Exchange - Core

## `v1.5.2`
This new version includes a lot of changes, especially to the way in which Trade Fees is distributed to the Voters.

## Implementations
### New (v1.5.5)

Contract | Implementation | Proxy
---- | ---- | ----
BribeFactory | 0xc8b6fcb95429eb1bc70863adf9e795719f4b7d79 | 0x58be1f04029ffdccbd34919fe0118cd207d746b0
GaugeFactory | 0xf438b2fdf46ea176ebf99ec7852c4699e8e38b1f | 0x5b3220cb732245ffe8e26df228ac93feb685c157
Voter        | 0x14A0b746803EC563BE405942259969F9Af985c20 | 0xE3D1A117dF7DCaC2eB0AC8219341bAd92f18dAC1
Minter       | 0x56A4e8C5FF356A8Cbb9312Fa31fBE482AC2B9CD5 | 0x85E7f59248d1c52BD635F27518333F75FB80C72D (unchanged)
VotingEscrow | 0x0e719D1bbEd13E9d0A49D37C6FD287F42cE5F862 | 0x8313f3551C4D3984FfbaDFb42f780D0c8763Ce94 (unchanged)

### Old (v1.3.16)

Contract | Implementation | Proxy
---- | ---- | ----
BribeFactory | 0x8868ae6de5e723e6840cdc21370e415bf5123684 | 0x5d4589bba42df0c53bbcb7ec59160de64b9d4308
GaugeFactory | 0xec42750285e41848c00bf745894e8bc233a264c6 | 0xc8be3d680e31187a94b47119c5b2b095ce2be578
Voter        | 0x1739fa484acd863ca527b2db50ac782f4522210b | 0x4bebEB8188aEF8287f9a7d1E4f01d76cBE060d5b
Minter       | 0x3215E01aC5cf536f768f07d68b6E75554a450B42 | 0x85E7f59248d1c52BD635F27518333F75FB80C72D (unchanged)
VotingEscrow | 0xD4F24608ca843140E3921B97c546329a1D8c8E1b | 0x8313f3551C4D3984FfbaDFb42f780D0c8763Ce94 (unchanged)

### Others

Contract | Implementation | Proxy
---- | ---- | ----
Factory | | 0xc6366efd0af1d09171fe0ebf32c7943bb310832a
Equal | | 0x3fd3a0c85b70754efc07ac9ac0cbbdce664865a6


### Diff


----


# Gameplan
Below is the procedure we are looking to adopt for migrating from the current contracts to new contracts. If you find any loopholes or anything thats missing, please inform us :)
- Order of executing each step is important.

*Note: hotload refers to the `initialize` function on the new implementation.*

## Basics
### 3-29 March

- [x] Deploy v2.Implementations
- [x] Deploy v2.Proxies
- [x] Initialize v2.voter
- [x] Add Whitelist tokens on v2.voter
- [x] Add Gaugeable tokens on v2.voter
- [x] Create new Gauges on v2.voter
- [x] TEST deposits/withdrawals from v2.Gauges
- [x] TEST notification of bribes from v2.Gauges.deposit/widthdraw/claim
- [ ] TEST overriding notification of bribes to v2.Gauges.feeTaker
- [x] TEST reward distribution
	- [x] TEST Notify 0.01 EQUAL rewards to gauges
	- [x] TEST deposits/withdrawals from v2.Gauges
	- [x] TEST notification of bribes from v2.Gauges.deposit/widthdraw/claim
	- [ ] TEST overriding notification of bribes to v2.Gauges.feeTaker

## Review
### 3-29 March

- [x] Get GamePlan reviewed by Peer 1
- [x] Get GamePlan reviewed by Peer 2
- [x] Get GamePlan reviewed by Peer 3
- [x] Get GamePlan reviewed by Peer 4
- [x] Get GamePlan reviewed by Peer 5
- [x] Get GamePlan reviewed by Peer 6
- [ ] Get GamePlan reviewed by Peer 7
- [ ] Get GamePlan reviewed by Peer 8
- [ ] Get GamePlan reviewed by Peer 9
- [ ] Get GamePlan reviewed by Peer 10
- [x] Get Contracts reviewed by Peer 1
- [x] Get Contracts reviewed by Peer 2
- [ ] Get Contracts reviewed by Peer 3
- [ ] Get Contracts reviewed by Peer 4
- [ ] Get Contracts reviewed by Peer 5
- [ ] Get Contracts reviewed by Peer 6
- [ ] Get Contracts reviewed by Peer 7


## Preparation
### 29 March, Wednesday

- [x] Re-create ALL old (v1) gauges using new Voter (v2).

- [x] Each team member should create 30 Special NFTs with 0.01 EQUAL max Locked
	- [x] Each team member should vote for 10 different gauges with each NFT
	- [x] Make sure to cover each & every pool with 10% votes of a NFT (10 pools x 15 NFTs)
	- [x] Make sure votes are in before 29 March ends.
- [x] Upgrade v1.Voter
	- [x] Block new votes from 30 March 12 am
	- [x] Introduce ResetOverride function
	- [x] Introduce retireTime variable: To make calls to distribute have no effect after retireTime
- [x] Upgrade v1.VENFT
	- [x] Introduce oldVoter variable: To allow attach/detach calls from v1.Gauges (oldVoter is still 0x00. Dont change yet)
	- [x] Introduce hotLoad function:
		- To load new Voter address into Venft contract (Dont call hotLoad yet)
		- To set oldVoter variable (Dont call hotLoad yet)
		- To set retireTime as time of hotLoading (Dont call hotLoad yet)
- [x] Upgrade v1.Minter
	- [x] Introduce hotLoad function: To load new Voter address into Minter contract (Dont call hotLoad yet)


## Core Switch
### 30 March, Thursday

- [x] Flip the epoch (v1.voter.distribute)
- [x] Distribute EQUAL emissions to all gauges
	- Make sure ALL gauges get as some rely on late friday distributions.
	- Make sure Voter contract does not contain any leftover distributions.
- [x] Start resetting everyone's votes via v1.voter.resetOverride (dont reset the 30 new special nfts held by each team member)
- [x] Again, make sure each & everyone's votes have been reset. Tally with v1.VENFT.voted(<id>).
- [ ] Call hotload on v1.Minter vvvv(TOGETHER!)vvvv
- [ ] Call hotload on v1.VENFT  ^^^^(TOGETHER!)^^^^
	- [ ] TEST voting using old v1.Voter.vote (MUST FAIL)
	- [ ] TEST voting using new v2.Voter.vote (MUST WORK)
	- [ ] TEST deposits via old v1.Gauges (MUST WORK)
	- [ ] TEST deposits via new v2.Gauges (MUST WORK)
	- [ ] TEST Each team member should vote for 10 different gauges with each NFT (MUST WORK)
	- [ ] TEST Make sure to cover each & every pool with 10% votes of a NFT (10 pools x 15 NFTs)
- [ ] TEST Wait some time, and then call v2.Gauges.deposit/withdraw (MUST WORK)
	- [ ] TEST if bribes are added to the v2.Gauges (MUST WORK)

## Final Announcement
### 5 April, Wednesday

- [ ] Ask Liquidity Providers to start moving to new Gauges
> *Maybe provide some pre-v2 incentives for v2.. reduce previous emission and add it here to v2? NOTE: if incentives are added, the tradeFees from such gauges would be sent to bribes, but at this point nobody can vote.. consider setting up an interim feeTaker meanwhile.*

## Migration
### 6 April, Thursday

- [ ] Flip the epoch using v2.voter.distrubute (MUST WORK)
- [ ] Distribute EQUAL emissions to ALL gauges (MUST WORK)
- [ ] TEST deposits via old v1.Gauges (MUST WORK)
- [ ] TEST if bribes are added to the v2.Gauges (MUST WORK)
- [ ] TEST voting using new v2.Voter.vote (MUST WORK)
- [ ] TEST Claim EQUAL Gauge emissions via v2.Gauges.getReward(<0xEqualAddress>) (MUST WORK)

## Aftermath
### 6 April - Future

- [ ] Claim old internal & external Bribes from v1 using the Special 30 team veNFTs
	- [ ] Send these to treasury (PoL?)



----
----
----
----
----
----
----
----
----
----

# Dev Roadmap with Checklist

## On/Before 29 March

- [x] Deploy new implementation: v2_voter
- [x] Deploy new implementation: v2_bribeFactory
- [x] Deploy new implementation: v2_gaugeFactory
- [x] Deploy new Proxy: v2_voter
- [x] Deploy new Proxy: v2_bribeFactory
- [x] Deploy new Proxy: v2_gaugeFactory

- [x] v2_voter : Initialize
- [x] v2_voter : Initial Setup
- [x] v2_voter : Whitelist Tokens
- [x] v2_voter : Set Gaugable Tokens
- [x] v2_voter : Create Gauges

- [x] v2_Gauges: Test deposit/withdraw/notify/claim
- [x] v2_Bribe: Test notify

- [x] v1_NFT: Create Special Team NFTs
- [x] v1_Voter: Vote ALL Gauges with Special Team NFTs

- [x] Deploy new implementation: v1_voter
- [x] v1_Voter: UPGRADE - Re-Enable public poke()
- [x] v1_Voter: UPGRADE - Add resetOverride()
- [x] v1_Voter: UPGRADE - Block vote() after 1680134400
- [x] v1_Voter: UPGRADE - Make distribute() useless at 1680739200-1

- [x] Deploy new implementation: v1_NFT
- [x] v1_NFT: UPGRADE - Add oldVoter variable
- [x] v1_NFT: UPGRADE - Add set-OLD-Voter() function (DONT CALL)
- [x] v1_NFT: UPGRADE - Add set-NEW-Voter() function (DONT CALL)
- [x] v1_NFT: UPGRADE - Allow attach/detach calls from oldVoter||voter

- [x] Deploy new implementation: v1_minter
- [x] v1_Minter: UPGRADE - Add set-Voter() function (DONT CALL)

## On 30 March

- [x] v1_voter: CALL distribute() to EQUAL emissions to ALL gauges
- [x] v1_voter: CALL resetOverride() on ALL venfts (Except Team NFTs)
- [x] v1_NFT: CHECK Make Sure all the NFTs are RESET (Except Special 30)
- [ ] v1_NFT: CALL setOldVoter()
- [ ] v1_NFT: CALL setNewVoter()
- [ ] v1_Minter: CALL setNewVoter()
- [ ] v1_Minter: CALL setEqualWftmGauge() with new v2 EQUALWFTM Guage


## On 5 April

- [ ] SIMULATE: v2_voter.distribute()

## On 6 April

- [ ] SIMULATE: v2_voter.distribute()
