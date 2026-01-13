/**
 *  EQUALIZER EXCHANGE
 *  The New Liquidity Hub of Fantom chain!
 *  https://equalizer.exchange  (Dapp)
 *  https://discord.gg/MaMhbgHMby   (Community)
 *
 *
 *  Contributors:
 *   -   543#3017 (Sam), ftm.guru, Equalizer.exchange & Eliteness.Network
 *
 *
*/

/*


//SPDX-License-Identifier: BUSL-1.1
Copyright 2024 Guru Network ftm1337@protonmail.com
Copyright 2024 Equalizer Exchange

Business Source License 1.1

License text copyright (c) 2017 MariaDB Corporation Ab, All Rights Reserved.
"Business Source License" is a trademark of MariaDB Corporation Ab.

-----------------------------------------------------------------------------

Parameters

Licensor:             Guru Network & Equalizer Exchange

Licensed Work:        SuperVoter, Artwork, Metadata, tangible or intangible parts,
                      or parts of, or any software or property derived therefrom.
                      The Licensed Work is (c) 2024 Guru Network and
                      the Licensed Work is (c) 2024 Equalizer Exchange

Additional Use Grant: Any uses listed and defined at
                      any Self-addressed transactions on Ethereum Mainnet from
                      0x1d99b3711c440cfbcc58ff5460d79b1f3eef2e31 with
                      explicit expression of Additional Use Grant

Change Date:          The earlier of 2028-12-31 or a date specified at
                      any Self-addressed transactions on Ethereum Mainnet from
                      0x1d99b3711c440cfbcc58ff5460d79b1f3eef2e31 with
                      explicit expression of Change Date

Change License:       GNU General Public License v2.0 or later

-----------------------------------------------------------------------------

Terms

The Licensor hereby grants you the right to copy, modify, create derivative
works, redistribute, and make non-production use of the Licensed Work. The
Licensor may make an Additional Use Grant, above, permitting limited
production use.

Effective on the Change Date, or the seventh anniversary of the first publicly
available distribution of a specific version of the Licensed Work under this
License, whichever comes first, the Licensor hereby grants you rights under
the terms of the Change License, and the rights granted in the paragraph
above terminate.

If your use of the Licensed Work does not comply with the requirements
currently in effect as described in this License, you must purchase a
commercial license from the Licensor, its affiliated entities, or authorized
resellers, or you must refrain from using the Licensed Work.

All copies of the original and modified Licensed Work, and derivative works
of the Licensed Work, are subject to this License. This License applies
separately for each version of the Licensed Work and the Change Date may vary
for each version of the Licensed Work released by Licensor.

You must conspicuously display this License on each original or modified copy
of the Licensed Work. If you receive the Licensed Work in original or
modified form from a third party, the terms and conditions set forth in this
License apply to your use of that work.

Any use of the Licensed Work in violation of this License will automatically
terminate your rights under this License for the current and all other
versions of the Licensed Work.

This License does not grant you any right in any trademark or logo of
Licensor or its affiliates (provided that you may use a trademark or logo of
Licensor as expressly required by this License).

TO THE EXTENT PERMITTED BY APPLICABLE LAW, THE LICENSED WORK IS PROVIDED ON
AN "AS IS" BASIS. LICENSOR HEREBY DISCLAIMS ALL WARRANTIES AND CONDITIONS,
EXPRESS OR IMPLIED, INCLUDING (WITHOUT LIMITATION) WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE, NON-INFRINGEMENT, AND
TITLE.

MariaDB hereby grants you permission to use this License’s text to license
your works, and to refer to it using the trademark "Business Source License",
as long as you comply with the Covenants of Licensor below.

-----------------------------------------------------------------------------

Covenants of Licensor

In consideration of the right to use this License’s text and the "Business
Source License" name and trademark, Licensor covenants to MariaDB, and to all
other recipients of the licensed work to be provided by Licensor:

1. To specify as the Change License the GPL Version 2.0 or any later version,
   or a license that is compatible with GPL Version 2.0 or a later version,
   where "compatible" means that software provided under the Change License can
   be included in a program with software provided under GPL Version 2.0 or a
   later version. Licensor may specify additional Change Licenses without
   limitation.

2. To either: (a) specify an additional grant of rights to use that does not
   impose any additional restriction on the right granted in this License, as
   the Additional Use Grant; or (b) insert the text "None".

3. To specify a Change Date.

4. Not to modify this License in any other way.

-----------------------------------------------------------------------------

Notice

The Business Source License (this document, or the "License") is not an Open
Source license. However, the Licensed Work will eventually be made available
under an Open Source License, as stated in this License.



-----------------------------------------------------------------------------
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
-----------------------------------------------------------------------------







FFFFF  TTTTTTT  M   M         GGGGG  U    U  RRRRR     U    U
FF       TTT   M M M M       G       U    U  RR   R    U    U
FFFFF    TTT   M  M  M      G  GGG   U    U  RRRRR     U    U
FF       TTT   M  M  M   O  G    G   U    U  RR R      U    U
FF       TTT   M     M       GGGGG    UUUU   RR  RRR    UUUU

					https://eliteness.network


						Contact us at:
			https://discord.com/invite/QpyfMarNrV
					https://t.me/FTM1337

	Community Mediums:
		https://medium.com/@ftm1337
		https://twitter.com/ftm1337
*/
// File: contracts/interfaces/IVotingEscrow.sol


pragma solidity 0.8.9;

interface IVoter {
	function _ve() external view returns(address);
	function lastVoted(uint tokenId) external view returns(uint);
	//
	function vote(uint tokenId, address[] memory _poolVote, uint256[] memory _weights) external;
	function poke(uint tokenId) external;
}

interface IVE {
    function balanceOf(address _user) external view returns (uint);
    function locked__end(uint _tokenId) external view returns (uint);
    function tokenOfOwnerByIndex(address _owner, uint _tokenIndex) external view returns (uint);
    function ownerOf(uint) external view returns (address);
    function isApprovedOrOwner(address, uint) external view returns (bool);
    //
    function increase_unlock_time(uint _tokenId, uint _lock_duration) external;
}

contract ReentrancyGuarded {
	/// @dev counter to allow mutex lock with only one SSTORE operation
	uint256 public interactions;

	bool public paused;
	address public pauser;

	/**
	/// constructor is useless in our initializable pattern.
	/// we set it up in the outermost initialization
	constructor () {
		// The counter starts at one to prevent changing it from zero to a non-zero
		// value, which is a more expensive operation.
		interactions = 1;
	}
	**/

	function setPaused(bool p) external {
		require(!p==paused && msg.sender == pauser,"!P");
		paused = p;
	}

	function setPauser(address p) external {
		require(msg.sender == pauser,"!P");
		pauser = p;
	}

	/**
	 * @dev Prevents a contract from calling itself, directly or indirectly.
	 * Calling a `Guarded` function from another `Guarded`
	 * function is not supported. It is possible to prevent this from happening
	 * by making the `Guarded` function external, and make it call a
	 * `private` function that does the actual work.
	 */
	modifier Guarded() {
		require(!paused,"P||");
		require(interactions % 2 == 0,"RG!");
		interactions += 1;
		uint256 localCounter = interactions;
		_;
		require(localCounter == interactions, "RG!!");
		interactions += 1;
	}
}

contract SuperVoter is ReentrancyGuarded {

	IVoter public immutable VOTER;
	IVE public immutable VE;
	mapping(address => address) public managerOf;
	event ManagerSet(address indexed client, address manager, uint when);

	constructor(IVoter _voter) {
		interactions=2;
		pauser = msg.sender;
		VOTER = _voter;
		VE = IVE(VOTER._ve());
	}

	function setManager(address _man) external Guarded {
		managerOf[ msg.sender ] = _man;
		emit ManagerSet(msg.sender, _man, block.timestamp);
	}

	function maxLockMultiple(uint[] memory _ids) external Guarded {
    	uint _max = block.timestamp / (1 weeks) * (1 weeks) + (26 weeks);
    	for(uint i; i<_ids.length; i++) {
    		//require( VE.isApprovedOrOwner(msg.sender, _ids[i]), "un-authorized!");
    		require(
    			VE.isApprovedOrOwner(msg.sender, _ids[i])
    			|| msg.sender == managerOf[ VE.ownerOf( _ids[i] ) ]
    			, "UA!"
    		);
    		uint _old = VE.locked__end( _ids[i] ) / (1 weeks) * (1 weeks) ;
    		if(_old < _max && _old > block.timestamp) {
	    	    VE.increase_unlock_time( _ids[i] , (26 weeks) ) ;
	    	}
    	}
	}

	function maxLockAll() external {
		maxLockAllFor(msg.sender);
	}

	function maxLockAllFor(address _user) public Guarded {
		uint _bal = VE.balanceOf(_user);
   		uint _max = block.timestamp / (1 weeks) * (1 weeks) + (26 weeks);
    	for(uint i; i<_bal; i++) {
    		uint _nid = VE.tokenOfOwnerByIndex(_user, i);
    		//require( VE.isApprovedOrOwner(msg.sender, _nid), "un-authorized!");
    		require(
    			msg.sender == _user
    			|| msg.sender == managerOf[ VE.ownerOf( _nid ) ]
    			|| VE.isApprovedOrOwner(msg.sender, _nid)
    			, "UA2!"
    		);
    		uint _old = VE.locked__end( _nid ) / (1 weeks) * (1 weeks) ;
    		if(_old < _max && _old > block.timestamp) {
	    	    VE.increase_unlock_time( _nid , (26 weeks) ) ;
	    	}
    	}
	}

    function voteMultiple(bool _maxlock, uint[] memory _ids, address[] calldata _poolVote, uint256[] calldata _weights) external Guarded {
    	uint _max = block.timestamp / (1 weeks) * (1 weeks) + (26 weeks);
    	for(uint i; i<_ids.length; i++) {
    		//require( VE.isApprovedOrOwner(msg.sender, _ids[i]), "un-authorized!");
    		require(
    			VE.isApprovedOrOwner(msg.sender, _ids[i])
    			|| msg.sender == managerOf[ VE.ownerOf( _ids[i] ) ]
    			, "un-authorized!"
    		);
    		if(_maxlock) {
    			uint _old = VE.locked__end( _ids[i] ) / (1 weeks) * (1 weeks) ;
    			if(_old < _max && _old > block.timestamp) {
	    	    	VE.increase_unlock_time( _ids[i] , (26 weeks) ) ;
	    		}
	    	}
    		VOTER.vote(_ids[i], _poolVote, _weights);
    	}
    }

    function voteAll(bool _maxlock, address[] calldata _poolVote, uint256[] calldata _weights) external {
    	voteAllFor(msg.sender, _maxlock, _poolVote, _weights);
    }

    function voteAllFor(address _user, bool _maxlock, address[] calldata _poolVote, uint256[] calldata _weights) public Guarded {
		uint _bal = VE.balanceOf(_user);
   		uint _max = block.timestamp / (1 weeks) * (1 weeks) + (26 weeks);
    	for(uint i; i<_bal; i++) {
    		uint _nid = VE.tokenOfOwnerByIndex(_user, i);
    		//require( VE.isApprovedOrOwner(msg.sender, _nid), "un-authorized!");
    		require(
    			msg.sender == _user
    			|| msg.sender == managerOf[ VE.ownerOf( _nid ) ]
    			|| VE.isApprovedOrOwner(msg.sender, _nid)
    			, "un-authorized!"
    		);
    		if(_maxlock) {
    			uint _old = VE.locked__end( _nid ) / (1 weeks) * (1 weeks) ;
    			if(_old < _max && _old > block.timestamp) {
	    	    	VE.increase_unlock_time( _nid , (26 weeks) ) ;
	    		}
	    	}
    		VOTER.vote(_nid, _poolVote, _weights);
    	}
    }

    function revoteMultiple(bool _maxlock, uint[] memory _ids) external Guarded {
    	uint _max = block.timestamp / (1 weeks) * (1 weeks) + (26 weeks);
    	for(uint i; i<_ids.length; i++) {
    		if(_maxlock) {
    			//require( VE.isApprovedOrOwner(msg.sender, _ids[i]), "un-authorized!");
    			require(
    				VE.isApprovedOrOwner(msg.sender, _ids[i])
    				|| msg.sender == managerOf[ VE.ownerOf( _ids[i] ) ]
    				, "un-authorized!"
    			);
    			uint _old = VE.locked__end( _ids[i] ) / (1 weeks) * (1 weeks) ;
    			if(_old < _max && _old > block.timestamp) {
	    	    	VE.increase_unlock_time( _ids[i] , (26 weeks) ) ;
	    		}
	    	}
    		VOTER.poke( _ids[i] );
    	}
    }
}