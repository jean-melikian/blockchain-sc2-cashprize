<template>
  <div>
    <span class='tournaments-entry'>Tournament: {{ name }}</span>
  </div>
</template>

<script>
  export default {
    name: 'tournaments-list-element',
    props: {
      name: {
        type: String,
        required: true
      }
    }
  }
</script>

<style scoped>

</style>
