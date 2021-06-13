// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract Multisig {

  mapping(address => bool) public isOwner;
  uint approvalLimit;

  struct TransferRequest {
    uint amount;
    address payable recipient;
    uint approvalCount;
    uint id;
    bool completed;
  }

  TransferRequest[] public transferRequests;
  mapping(address => mapping(uint => bool)) public voted;

  modifier ownersOnly {
    require(isOwner[msg.sender] == true, "Not accessible to unauthorized owners");
    _;
  }

  constructor(address _owner1, address _owner2, address _owner3, uint _limit) public {
    isOwner[_owner1] = true;
    isOwner[_owner2] = true;
    isOwner[_owner3] = true;
    approvalLimit = _limit;
  }

  // accept public deposits
  function deposit() public payable {
    require(msg.value >= 1000);
  }

  function transferRequest(uint _amount, address payable _recipient) public ownersOnly {
    require(address(this).balance >= _amount, "Requested Amount exceeds available balance");
    transferRequests.push(TransferRequest(_amount, _recipient, approvalLimit, transferRequests.length, false));
    approveRequest(transferRequests.length);
  }

  function approveRequest(uint _id) public {
    require(voted[msg.sender][_id] == false, "user already voted on this proposal");
    voted[msg.sender][_id] = true;
    transferRequests[_id].approvalCount ++;

    uint _approvals = transferRequests[_id].approvalCount;

    if(_approvals >= approvalLimit) {
      uint _prevBalance = address(this).balance;
      transferRequests[_id].recipient.transfer(transferRequests[_id].amount);
      assert(address(this).balance == _prevBalance - transferRequests[_id].amount);
      transferRequests[_id].completed = true;
      }
    }
}
