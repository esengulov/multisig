// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract Multisig {

  address[] public owners;
  mapping(address => bool) public isOwner;
  mapping(address => bool) public voted;
  uint public approvalCount;
  uint public approvalLimit;
  bool public voteInProgress;

  uint amount;
  address payable recipient;

  modifier ownersOnly {
    require(isOwner[msg.sender] == true, "Not accessible to unauthorized owners");
    _;
  }

  constructor(address _owner1, address _owner2, address _owner3, uint _limit) public {
    owners.push(_owner1);
    owners.push(_owner2);
    owners.push(_owner3);
    isOwner[_owner1] = true;
    isOwner[_owner2] = true;
    isOwner[_owner3] = true;

    approvalLimit = _limit;
    approvalCount = 0;
    voteInProgress = false;
  }

  // accept public deposits
  function deposit() public payable {
    require(msg.value >= 1000);
  }

  function transferRequest(uint _amount, address payable _recipient) public ownersOnly {
    require(address(this).balance >= _amount, "Amount exceeds contract's balance");
    require(voteInProgress == false, "there is pending proposal");

    amount = _amount;
    recipient = _recipient;
    voteInProgress = true;

    _approve();
  }

  function _approve() private {
    require(voted[msg.sender] == false, "owner already voted");
    voted[msg.sender] = true;
    approvalCount ++;

    if(approvalCount >= approvalLimit) {
      // reset everything
      approvalCount = 0;
      voteInProgress = false;
      for(uint i = 0; i <= owners.length; i++){
        voted[owners[i]] = false;
      }

      // approve withdraw
      uint _prevBalance = address(this).balance;
      recipient.transfer(amount);
      assert(address(this).balance == _prevBalance - amount);
      // reset recipient and amount
      amount = 0;
      recipient = address(0);
    }
  }
}
