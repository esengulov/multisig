// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

import "./Team.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract Treasury is Team {
  using SafeMath for uint;

  uint approvalLimit;

  struct TransferRequest {
    uint amount;
    address payable recipient;
    uint approvalCount;
    uint id;
    bool completed;
  }

  TransferRequest[] public transferRequests;
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
      payTeam(transferRequests[_id].amount);
      transferRequests[_id].completed = true;
    }
  }

  function payTeam(uint256 _amount) private {
    uint newPayment = SafeMath.div(_amount, memberCount);
    for(uint i = 0; i < members.length; i++) {
      if(isActiveMember[members[i].wallet] == true) {
        members[i].allowance = SafeMath.add(members[i].allowance, newPayment);
      }
    }
  }

  function requestCount() public view virtual returns(uint) {
    return transferRequests.length;
  }

}
