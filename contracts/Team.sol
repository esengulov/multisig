// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract Team {

  struct Member {
    uint id;
    address wallet;
    uint allowance;
  }

  Member[] members;
  mapping(address => bool) isTeamMember;
  uint activeMembers;
  address admin;



  modifier teamOnly {
    require(isTeamMember[msg.sender] == true, "Not accessible to non-team members");
    _;
  }

  modifier adminOnly {
    require(msg.sender == admin, "Not accessible to non-admin members");
    _;
  }

  constructor(address[] memory _members) public {
    for(uint i = 0; i < _members.length; i++) {
      address wallet = _members[i];
      members.push(Member(i, _members[i], 0));
      activeMembers ++;
    }
    admin = msg.sender;
  }

  function addMember(address _newmember) public adminOnly {
    members.push(Member(members.length, _newmember, 0));
    isTeamMember[_newmember] = true;
    activeMembers ++;
  }

  function removeMember(address _oldmember) public adminOnly {
    isTeamMember[_oldmember] = false;
    activeMembers --;
  }
}