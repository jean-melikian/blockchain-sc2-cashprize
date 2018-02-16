pragma solidity ^0.4.16;

contract Sc2Tournaments {

  struct Tournament {
    uint id;
    string name;
	int cashprize;
    int registrationFees;
	int maxPeople;
    Player[] players;
    Match[] matches;
  }

  struct Player {
      string name;
      string race;
      //address playerAddress;
  }

  struct Match {
    uint id;
    string player1;
    string player2;
    int winner; // 0 no win; 1 player1 won; 2 player2 won
    int round; //round of 32(16eme final), round of 16(8eme de final) etc...
  }

  mapping(address => uint) public balances;


  event withdraw(address from, address to, uint amount);
  address owner;
  uint cashprize;

  function Sc2Tournaments() public {
        owner = msg.sender;
  }


  function CreateTournament(string name, int registrationFees, int maxPeople) public{
    //TODO Check if tournament name doesn't exists
    Player[]  players;
    Match[]  matches;

    /*tournaments.push(Tournament({
        id:3 ,
        name:name,
        cashprize:4,
        registrationFees:registrationFees,
        maxPeople:maxPeople,
        players:players,
        matches:matches
        }));*/
    tournaments.push(Tournament(3,name,4,3,3,players,matches));
  }

  function CreateMatch(string player1Name, string player2name,int round,uint tournamentId)public{
    tournaments[tournamentId].matches.push(Match({
      id:tournaments[tournamentId].matches.length,
      player1:player1Name,
      player2:player2name,
      winner:0,
      round:round
      }));
  }

  function MatchResult(int winner, uint tournamentId,uint matchId )public{
    tournaments[tournamentId].matches[matchId].winner = winner;
    //TODO: Check if next match is created --> create it if not

  }

    function Inscription(string playerName, string race, uint fees) payable {
        var _playerName = playerName;
        require(balances[msg.sender] > fees);

        //safes.push(Safe({owner: msg.sender, fees))
        balances[msg.sender]+=fees;
        cashprize += fees;
    }

    function Withdraw(Player player, uint idTournoi) payable{
        require(balances[msg.sender] < tournaments[idTournoi].cashprize);
        require(msg.sender != owner);

        balances[msg.sender] -= tournaments[idTournoi].cashprize;
        player.playerAddress += tournaments[idTournoi].cashprize;
        withdraw(msg.sender, player.playerAddress, tournaments[idTournoi].cashprize);
    }

}
