pragma solidity ^0.4.16;

contract Sc2Tournaments {

  struct Tournament {
    uint id;
    string name;
    uint cashprize;
    uint registrationFees;
    uint maxPeople;
    uint actualPeople;
    uint ActualNumberOfMatch;
    mapping(uint => Player) players;
    mapping(uint => Match) matches;
  }

  struct Player {
    string name;
    string race;
    address playerAddress;
  }

  struct Match {
    uint id;
    string player1;
    string player2;
    int winner; // 0 no win; 1 player1 won; 2 player2 won
    int round; //round of 32(16eme final), round of 16(8eme de final) etc...
  }

  uint public tournamentsCount = 0;
  mapping(address => uint) public balances;
  mapping(uint => Tournament) public tournaments;


  event withdraw(address from, address to, uint amount);

  address owner;
  uint cashprize;

  function Sc2Tournaments() public {
    owner = msg.sender;
  }

  function CreateTournament(string name, uint registrationFees, uint maxPeople) public {
    //TODO Check if tournament name doesn't exists

    uint id = tournamentsCount++;

    tournaments[id].name = name;
    tournaments[id].cashprize = registrationFees * maxPeople;
    tournaments[id].registrationFees = registrationFees;
    tournaments[id].maxPeople = maxPeople;

  }

/*  function GetTournamentPlayer(uint tournamentId)
    public
    returns (string[] playerName,string[] playerRace,address[] playerAddress)
  {

    uint constant range = tournaments[tournamentId].actualPeople;

    address[range]  playAddress;
    string[range]  name;
    string[range]  race;

    for (uint i = 0; i < range; i++) {
        name.push(tournaments[tournamentId].players[i].name);
        race.push(tournaments[tournamentId].players[i].race);
        playAddress.push(tournaments[tournamentId].players[i].playerAddress);
    }

    return (name, race,playerAddress);
  }*/

  function CreateMatch(uint id, string player1Name, string player2Name, int round, uint tournamentId) public {
    tournaments[tournamentId].matches[id].player1 = player1Name;
    tournaments[tournamentId].matches[id].player2 = player2Name;
    tournaments[tournamentId].matches[id].round = round;

  }

  function MatchResult(int winner, uint tournamentId, uint matchId) public {
    tournaments[tournamentId].matches[matchId].winner = winner;
    //TODO: Check if next match is created --> create it if not

  }

  function Inscription(string playerName, string race, uint tournamentId) public payable {
    /*require(balances[msg.sender] > tournaments[tournamentId].registrationFees);

    //safes.push(Safe({owner: msg.sender, fees))
    balances[msg.sender] -= tournaments[tournamentId].registrationFees;
    //cashprize += fees;

    require(tournaments[tournamentId].actualPeople < tournaments[tournamentId].maxPeople);
    */uint id = tournaments[tournamentId].actualPeople++;

    tournaments[tournamentId].players[id].race = race;
    tournaments[tournamentId].players[id].name = playerName;

  }

  /*function Withdraw(address playerA, uint idTournoi) public payable{
      require(balances[msg.sender] < tournaments[idTournoi].cashprize);
      require(msg.sender != owner);

      balances[msg.sender] -= tournaments[idTournoi].cashprize;
      player.playerAddress += tournaments[idTournoi].cashprize;
      withdraw(msg.sender, player.playerAddress, tournaments[idTournoi].cashprize);
  }*/

}
