// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract Team {

  mapping(address => bool) isTeamMember;
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
      isTeamMember[_members[i]] = true;
    }
    admin = msg.sender;
  }

  function addMember(address payable _newmember) public adminOnly {
    isTeamMember[_newmember] = true;
  }

  function removeMember(address payable _oldmember) public adminOnly {
    isTeamMember[_oldmember] = false;
  }
}