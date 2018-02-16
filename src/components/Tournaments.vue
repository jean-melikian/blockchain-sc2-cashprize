<template>
  <section id='tournaments'>
    <h1>Tournaments</h1>
    <div class="form">
      <div class="entry">
        <input placeholder="Name" name="name" v-model="form.name">
        <input placeholder="Registration fees" name="registrationFees" v-model="form.registrationFees" type="number">
        <input placeholder="Max players" name="maxPeople" v-model="form.maxPeople" type="number">
        <button @click="createTournament" name="createTournament">Create tournament</button>
      </div>
    </div>
    <signup/>
    <h1>Tournaments list</h1>
    <button @click="refreshTournaments" name="refreshTournaments">Refresh tournaments</button>
    <ul id="tournaments-list">
      <template v-for="entry in entries">
        <li>
          <tournaments-list-element :name="entry"/>
        </li>
        <li class="divider"></li>
      </template>
    </ul>
  </section>
</template>

<script>
  import Tournaments from '@/js/tournaments'
  import TournamentsListElement from "./TournamentsListElement"
  import Signup from "./Signup"

  export default {
    components: {
      Signup,
      TournamentsListElement},
    name: 'tournaments',
    data() {
      return {
        form: {
          name: undefined,
          registrationFees: undefined,
          maxPeople: undefined,
          entries: undefined
        }
      }
    },
    beforeCreate: function () {
      Tournaments.init()
      this.entries = [
        "Hello", "world"
      ]
    },
    created: function () {

    },
    methods: {
      createTournament: function () {
        let self = this
        if (typeof this.form.name !== 'undefined' && this.form.name !== ''
          && typeof this.form.registrationFees !== 'undefined' && this.form.registrationFees !== 0
          && typeof this.form.maxPeople !== 'undefined' && this.form.maxPeople !== 0) {
          Tournaments.createTournament(this.form.name, this.form.registrationFees, this.form.maxPeople).then(tx => {
            console.log(tx)
            self.$router.push('/')
          }).catch(err => {
            console.log(err)
          })
        }
      },

      refreshTournaments: function() {

        Tournaments.getTournament(0).then(tournament => {
          console.log(tournament)
        }).catch(err => {
          console.log(err)
        })
      }
    }
  }
</script>

<style lang="scss" scoped>

  #signup {
    text-align: center;

    .form {
      display: flex;
      flex-direction: column;
      margin: auto;

      .entry {
        display: flex;
        flex-direction: row-reverse;
        justify-content: center;

        label {
          margin-right: 20px
        }

        button {
          margin-left: 20px
        }

      }

    }

  }

  ul#tournaments-list {
    width: 700px;
    margin: auto
  }

  ul#tournaments-list li {
    list-style: none;
    margin: 10px;
  }

  li.divider {
    border-bottom: solid 1px black;
  }

</style>
