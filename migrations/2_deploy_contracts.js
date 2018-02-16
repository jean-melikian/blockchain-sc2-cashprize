var Users = artifacts.require("./Users.sol");
var Tournaments = artifacts.require("./Tournaments.sol");

module.exports = function(deployer) {
  deployer.deploy(Users);
  deployer.deploy(Tournaments);
};
