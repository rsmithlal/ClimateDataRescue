<template>
  <div>
    <div>
      Observer: {{ page_info.attributes.observer }} |
      Lat: {{ page_info.attributes.lat }} |
      Lon: {{ page_info.attributes.lon }} |
      Location: {{ page_info.attributes.location }} |
      Elevation: {{ page_info.attributes.elevation }} |
      Month: {{ page_info.attributes.month }} |
      Year: {{ page_info.attributes.year }}
    </div>
  </div>
</template>

<script>
export default {
  name: 'TableCellPageInfo',
  props: {
    page_info: {
      type: Object,
      required: true
    }
  }
}
</script>

<style scoped lang="scss">

</style>
