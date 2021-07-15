// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

contract Team {

  struct Member {
    uint id;
    address wallet;
    uint256 allowance;
  }

  Member[] public members;
  mapping(address => bool) isActiveMember;
  uint256 public memberCount;

  address admin;

  modifier teamOnly {
    require(isActiveMember[msg.sender] == true, "Not accessible to non-team members");
    _;
  }

  modifier adminOnly {
    require(msg.sender == admin, "Not accessible to non-admin members");
    _;
  }

  constructor(address[] memory _members) public {
    memberCount = 0;
    for(uint i = 0; i < _members.length; i++) {
      address wallet = _members[i];
      members.push(Member(i, _members[i], 0));
      isActiveMember[_members[i]] = true;
      memberCount ++;
    }
    admin = msg.sender;
  }

  function addMember(address _new) public adminOnly {
    members.push(Member(members.length, _new, 0));
    isActiveMember[_new] = true;
    memberCount ++;
  }

  function removeMember(address _old) public adminOnly {
    isActiveMember[_old] = false;
    memberCount --;
  }

}
