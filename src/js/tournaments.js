import contract from 'truffle-contract'
import TournamentsContract from '@contracts/Tournaments.json'

const Tournaments = {

  contract: null,

  instance: null,

  init: function () {
    let self = this

    return new Promise(function (resolve, reject) {
      self.contract = contract(TournamentsContract)
      self.contract.setProvider(window.web3.currentProvider)

      self.contract.deployed().then(instance => {
        self.instance = instance
        resolve()
      }).catch(err => {
        reject(err)
      })
    })
  },

  createTournament: function (name, registrationFees, maxPeople) {
    let self = this

    return new Promise((resolve, reject) => {
      self.instance.CreateTournament(
        name,
        registrationFees,
        maxPeople,
        {from: window.web3.eth.accounts[0]}
      ).then(tx => {
        resolve(tx)
      }).catch(err => {
        reject(err)
      })
    })
  },

  getTournament: function (id) {
    let self = this

    return new Promise((resolve, reject) => {
      self.instance.GetTournament.call(
        id,
        {from: window.web3.eth.accounts[0]}
      ).then(tournament => {
        resolve(tournament)
      }).catch(err => {
        reject(err)
      })
    })
  },

  inscription: function (playerName, race, tournamentId) {
    let self = this

    return new Promise((resolve, reject) => {
      self.instance.Inscription(
        playerName,
        race,
        tournamentId,
        {from: window.web3.eth.accounts[0]}
      ).then(tx => {
        resolve(tx)
      }).catch(err => {
        reject(err)
      })
    })
  },

}

export default Tournaments
