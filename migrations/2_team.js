const multisig = artifacts.require("Multisig");
const members = ['0x1d5cb132066128a134bb544330a64cdab914ee27', '0xaf3f381a92662b7df10d8fce2346dbad8db4a0de', '0xd6e85ac83481666e9ab561957f99722658cdd0d1'];
const multisigCount = 2;

module.exports = function(deployer) {
  deployer.deploy(multisig, multisigCount, members);
};

