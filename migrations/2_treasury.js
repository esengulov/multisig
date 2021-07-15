const treasury = artifacts.require("Treasury");
const multisigCount = 2;

const { accounts, defaultSender, contract } = require('@openzeppelin/test-environment');
const teamMembers = [accounts[0], accounts[1], accounts[2]];
console.log(accounts);


module.exports = function(deployer) {
  deployer.deploy(treasury, multisigCount, teamMembers);
};
