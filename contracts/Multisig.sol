// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "./Team.sol";

contract Multisig is Team {

  uint approvalLimit;

  struct TransferRequest {
    uint amount;
    address payable recipient;
    uint approvalCount;
    uint id;
    bool completed;
  }

  TransferRequest[] transferRequests;
  mapping(address => mapping(uint => bool)) voted;

  constructor(uint _limit, address[] memory members) Team(members) public {
    approvalLimit = _limit;
  }

  // accept public deposits
  function deposit() public payable {
  }

  function transferRequest(uint _amount, address payable _recipient) public teamOnly {
    require(address(this).balance >= _amount, "Requested Amount exceeds available balance");
    transferRequests.push(TransferRequest(_amount, _recipient, 0, transferRequests.length, false));
    approveRequest(transferRequests.length);
  }

  function approveRequest(uint _id) public teamOnly {
    require(voted[msg.sender][_id] == false, "user already voted on this proposal");
    voted[msg.sender][_id] = true;
    transferRequests[_id].approvalCount ++;
    uint _approvals = transferRequests[_id].approvalCount;
    if(_approvals >= approvalLimit) {
      transferRequests[_id].recipient.transfer(transferRequests[_id].amount);
      transferRequests[_id].completed = true;
    }
  }
}
