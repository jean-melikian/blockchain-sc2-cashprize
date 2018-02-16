<template>
  <section id='signup'>
    <h1>Sign up</h1>
    <div class="form">
      <div class="entry">
        <div v-if="typeof this.form.pseudo !== 'undefined' && this.form.pseudo !== ''
         && typeof this.form.race !== 'undefined' && this.form.race !== ''
         && typeof this.form.tournamentId !== 'undefined' && this.form.tournamentId !== ''">
          <span>{{ form.pseudo }} selected the {{ form.race }} race</span>
        </div>
        <div v-else>
          <span>Please, enter your name and select a race. Do not forget the tournament id.</span>
        </div>
        <br>
        <input placeholder="Pseudo" name="pseudo" v-model="form.pseudo">
        <select name="race" v-model="form.race">
          <option>Terran</option>
          <option>Zerg</option>
          <option>Protoss</option>
        </select>
        <input placeholder="Tournament ID" name="tournamentId" v-model="form.tournamentId" type="number">

        <button @click="signup" name="signup">Sign up</button>
      </div>
    </div>
  </section>
</template>

<script>
  import Tournaments from '@/js/tournaments'

  export default {
    name: 'signup',
    data() {
      return {
        form: {
          pseudo: undefined,
          race: undefined,
          tournamentId: undefined
        }
      }
    },
    beforeCreate: function () {
      Tournaments.init()
    },
    methods: {
      signup: function () {
        let self = this
        if (typeof this.form.pseudo !== 'undefined' && this.form.pseudo !== ''
          && typeof this.form.race !== 'undefined' && this.form.race !== ''
          && typeof this.form.tournamentId !== 'undefined' && this.form.tournamentId !== '') {
          Tournaments.inscription(this.form.pseudo, this.form.race, this.form.tournamentId).then(tx => {
            console.log(tx)
            self.$router.push('/')
          }).catch(err => {
            console.log(err)
          })
        }
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

</style>
