const { expect } = require('chai');
const { BN, expectRevert, expectEvent } = require('@openzeppelin/test-helpers');
// const { accounts, defaultSender, contract } = require('@openzeppelin/test-environment');

const treasury = artifacts.require("Treasury");


contract("Treasury Deployment", function (/* accounts */) {

  beforeEach(async function () {
    this.contract = await treasury.deployed();
  });

  it("is deployed", async function () {
    await treasury.deployed();
    return assert.isTrue(true);
  });

  it('has a team  with 3 members', async function () {
    const memberCount = new BN('3')
    expect(await this.contract.memberCount()).to.be.bignumber.equal(memberCount);
  });

});

contract("Treasury Deposits", function (/* accounts */) {

  beforeEach(async function () {
    this.contract = await treasury.deployed();
  });

  it('accepts ETH deposits', async function () {
    return assert.isTrue(false);
  });

  it('accepts ERC20 deposits', async function () {
    return assert.isTrue(false);
  });

});


contract("Treasury Requests", function (/* accounts */) {

  beforeEach(async function () {
    this.contract = await treasury.deployed();
  });

  it('allows team members create transfer requests', async function () {
    return assert.isTrue(false);
  });

  it('reverts if transferRequest called by a non-team member', async function () {
    return assert.isTrue(false);
  });

});

contract("Team : Add Members", function (/* accounts */) {

  beforeEach(async function () {
    this.contract = await treasury.deployed();
  });

  it('allows admin to add team members', async function () {
    return assert.isTrue(false);
  });

  it('throws when non-admin tries to add member', async function () {
    return assert.isTrue(false);
  });

  it('makes a new member an active member', async function () {
    return assert.isTrue(false);
  });

  it('sets allowance to new member at 0', async function () {
    return assert.isTrue(false);
  });

  it('increases members array length by 1', async function () {
    return assert.isTrue(false);
  });

});

contract("Team : Remove Members", function (/* accounts */) {

  beforeEach(async function () {
    this.contract = await treasury.deployed();
  });

  it('allows admin to remove team members', async function () {
    return assert.isTrue(false);
  });

  it('throws when non-admin tries to remove member', async function () {
    return assert.isTrue(false);
  });

  it('makes a new member an inactive member', async function () {
    return assert.isTrue(false);
  });

  it('decreases members array length by 1', async function () {
    return assert.isTrue(false);
  });

});
