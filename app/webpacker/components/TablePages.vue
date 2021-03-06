
<template>
  <b-container
    class="pages-table-wrapper mb-3"
    fluid
  >
    <b-row
      class="pagination-row"
    >
      <b-col>
        <b-input-group
          class="mb-0 page-size-group"
          prepend="Per page"
        >
          <b-form-select
            v-model="perPage"
            :options="pageOptions"
            class="page-size-selector"
            name="page_size"
          />
        </b-input-group>
      </b-col>
      <b-col>
        <b-pagination
          v-model="currentPage"
          class="my-0"
          align="right"
          :total-rows="totalRows"
          :per-page="perPage"
        />
      </b-col>
    </b-row>
    <b-row>
      <b-col>
        <b-table
          ref="table"
          class="pages-table"
          selectable
          responsive
          no-local-sorting
          no-footer-sorting
          no-sort-reset
          striped
          hover
          sticky-header="70vh"
          primary-key="id"
          empty-text="No pages found"
          empty-filter-text="No pages match your filters"
          :show-empty="true"
          :items="getFilteredPages"
          :fields="fields"
          :current-page="currentPage"
          :per-page="perPage"
          :sort-by.sync="sortBy"
          :sort-desc.sync="sortDesc"
          :sort-direction="sortDirection"
          @row-selected="rowSelected"
        >
          <!-- TH contents -->
          <template
            v-slot:head(selected)="data"
          >
            <b>{{ data.label }}</b>

            <b-form-checkbox
              v-model="selectAll"
              @change="toggleSelectAll"
            />
          </template>
          <template
            v-slot:head(id)="data"
          >
            <b>{{ data.label }}</b>

            <table-filter-text
              v-model="filters.id"
              class="id"
            />
          </template>
          <template
            v-slot:head(title)="data"
          >
            <b>{{ data.label }}</b>

            <table-filter-text
              v-model="filters.title"
              class="title"
            />
          </template>
          <template
            v-slot:head(image_file_name)="data"
          >
            <b>{{ data.label }}</b>

            <table-filter-text
              v-model="filters.image_file_name"
              class="image_file_name"
            />
          </template>
          <template
            v-slot:head(start_date)="data"
          >
            <b>{{ data.label }}</b>

            <table-filter-text
              v-model="filters.start_date"
              class="start_date"
            />
          </template>
          <template
            v-slot:head(end_date)="data"
          >
            <b>{{ data.label }}</b>

            <table-filter-text
              v-model="filters.end_date"
              class="end_date"
            />
          </template>
          <template
            v-slot:head(page_type_id)="data"
          >
            <b>{{ data.label }}</b>

            <table-filter-select
              v-model="filters.page_type_id"
              :options="filterOptionsPageType"
              class="page_type_id"
            />
          </template>
          <template
            v-slot:head(page_days)="data"
          >
            <b>{{ data.label }}</b>

            <table-filter-boolean
              v-model="filters.page_days"
              class="page_days"
            />
          </template>
          <template
            v-slot:head(transcriptions)="data"
          >
            <b>{{ data.label }}</b>

            <table-filter-boolean
              v-model="filters.transcriptions"
              class="transcriptions"
            />
          </template>
          <template
            v-slot:head(visible)="data"
          >
            <b>{{ data.label }}</b>

            <table-filter-boolean
              v-model="filters.visible"
              class="visible"
            />
          </template>
          <template
            v-slot:head(done)="data"
          >
            <b>{{ data.label }}</b>

            <table-filter-boolean
              v-model="filters.done"
              class="done"
            />
          </template>

          <!-- Cells -->
          <template
            v-slot:cell(done)="data"
          >
            <span v-if="data.item.attributes.done">✔</span>
          </template>
          <template
            v-slot:cell(end_date)="data"
          >
            {{ data.item.attributes.end_date }}
          </template>
          <template
            v-slot:cell(image_file_name)="data"
          >
            {{ data.item.attributes.image_file_name }}
          </template>
          <template
            v-slot:cell(id)="data"
          >
            <b-link :href="data.item.links.admin_detail">
              {{ data.item.id }}
            </b-link>
          </template>
          <template
            v-slot:cell(page_type_id)="data"
          >
            <b-link
              v-if="data.item.page_type"
              :href="data.item.page_type.links.admin_detail"
            >
              {{ data.item.page_type.attributes.title }}
            </b-link>
          </template>
          <template
            v-slot:cell(page_days)="data"
          >
            <TableCellPageDays
              :page_days="data.item.page_days"
            />
          </template>
          <template
            v-slot:cell(selected)="data"
          >
            <span v-if="data.rowSelected">✔</span>
          </template>
          <template
            v-slot:cell(start_date)="data"
          >
            {{ data.item.attributes.start_date }}
          </template>
          <template
            v-slot:cell(title)="data"
          >
            <b-link :href="data.item.links.admin_detail">
              {{ data.item.attributes.title }}
            </b-link>
          </template>
          <template
            v-slot:cell(transcriptions)="data"
          >
            <TableCellPageTranscriptions
              :transcriptions="data.item.transcriptions"
            />
          </template>
          <template
            v-slot:cell(visible)="data"
          >
            <span v-if="data.item.attributes.visible">✔</span>
          </template>
          <template
            v-slot:cell(created_at)="data"
          >
            {{ data.item.attributes.created_at_datestring }}
          </template>
          <template
            v-slot:cell(updated_at)="data"
          >
            {{ data.item.attributes.updated_at_datestring }}
          </template>
          <template
            v-slot:cell(actions)="data"
          >
            <b-button
              block
              variant="primary"
              :href="data.item.links.admin_edit"
            >
              Edit
            </b-button>
            <b-button
              block
              variant="danger"
              :href="data.item.links.admin_delete"
              data-method="DELETE"
              :data-confirm="`Are you sure you want to delete page #${data.item.id}: ${data.item.attributes.title}?`"
            >
              Delete
            </b-button>
          </template>
        </b-table>
      </b-col>
    </b-row>
    <b-row
      class="pagination-row"
    >
      <b-col>
        <b-input-group
          class="mb-0 page-size-group"
          prepend="Per page"
        >
          <b-form-select
            v-model="perPage"
            :options="pageOptions"
            class="page-size-selector"
            name="page_size"
          />
        </b-input-group>
      </b-col>
      <b-col>
        <b-pagination
          v-model="currentPage"
          class="my-0"
          align="right"
          :total-rows="totalRows"
          :per-page="perPage"
        />
      </b-col>
    </b-row>
  </b-container>
</template>

<script>
import { mapActions } from 'vuex'
import TableCellPageDays from './TableCellPageDays'
import TableCellPageTranscriptions from './TableCellPageTranscriptions'
import TableFilterBoolean from './TableFilterBoolean'
import TableFilterSelect from './TableFilterSelect'
import TableFilterText from './TableFilterText'
import UrlHelpers from '../mixins/UrlHelpers'

export default {
  name: 'TablePages',
  components: {
    TableCellPageDays,
    TableCellPageTranscriptions,
    TableFilterBoolean,
    TableFilterSelect,
    TableFilterText
  },
  mixins: [UrlHelpers],
  data () {
    return {
      fields: [
        {
          key: 'actions',
          label: '',
          class: 'actions',
          sortable: false
        },
        {
          key: 'id',
          label: 'ID',
          class: 'id number',
          sortable: true
        },
        {
          key: 'title',
          label: 'Title',
          class: 'title',
          sortable: true
        },
        {
          key: 'image_file_name',
          label: 'Filename',
          class: 'filename',
          sortable: true
        },
        {
          key: 'start_date',
          label: 'Start Date',
          class: 'start-date',
          sortable: true
        },
        {
          key: 'end_date',
          label: 'End Date',
          class: 'end-date',
          sortable: true
        },
        {
          key: 'visible',
          label: 'Visible',
          class: 'visible',
          sortable: false
        },
        {
          key: 'done',
          label: 'Complete',
          class: 'done',
          sortable: false
        },
        {
          key: 'page_type_id',
          label: 'Schema',
          class: 'page-type-id',
          sortable: false
        },
        {
          key: 'page_days',
          label: 'Metadata',
          class: 'page-days',
          sortable: false
        },
        {
          key: 'transcriptions',
          label: 'Transcriptions',
          class: 'transcriptions',
          sortable: false
        },
        {
          key: 'created_at',
          label: 'Created',
          class: 'created-at',
          sortable: true
        },
        {
          key: 'updated_at',
          label: 'Updated',
          class: 'updated-at',
          sortable: true
        }
      ],
      pages: [],
      page_days: [],
      page_types: [],
      transcriptions: [],
      selected: [],
      filters: {
        done: null,
        end_date: '',
        id: '',
        image_file_name: '',
        page_type_id: null,
        page_days: null,
        start_date: '',
        title: '',
        transcriptions: null,
        visible: null
      },
      totalRows: 1,
      currentPage: 1,
      perPage: 10,
      pageOptions: [10, 15, 25, 50, 100],
      selectAll: false,
      sortBy: 'created_at',
      sortDesc: true,
      sortDirection: 'asc'
    }
  },
  computed: {
    filterOptionsPageType () {
      return [...this.page_types].sort((a, b) => {
        const nameA = a.attributes.title.toUpperCase() // ignore upper and lowercase
        const nameB = b.attributes.title.toUpperCase() // ignore upper and lowercase
        if (nameA < nameB) {
          return -1
        }
        if (nameA > nameB) {
          return 1
        }

        // names must be equal
        return 0
      }).map(pageType => {
        return { value: pageType.id, text: pageType.attributes.title }
      })
    }
  },
  watch: {
    filters: {
      handler () {
        // Refresh the table when the filter values change
        this.$refs.table.refresh()
      },
      deep: true
    }
  },
  mounted () {
    // Set the initial number of pages
    this.totalRows = this.pages.length
  },
  methods: {
    ...mapActions('pages', ['getPages']),
    rowSelected (rows) {
      // Set the selected data to the rows
      this.selected = rows

      this.selectAll = this.selected.length === this.pages.length
    },
    getFilteredPages (ctx) {
      // Must return a promise that resolves to an array of items
      return this.getPages({
        'page[number]': this.currentPage,
        'page[size]': this.perPage,
        'sort[key]': ctx.sortBy,
        'sort[desc]': ctx.sortDesc,
        'filters[done]': this.filters.done,
        'filters[end_date]': this.filters.end_date,
        'filters[id]': this.filters.id,
        'filters[image_file_name]': this.filters.image_file_name,
        'filters[page_type_id]': this.filters.page_type_id,
        'filters[page_days]': this.filters.page_days,
        'filters[start_date]': this.filters.start_date,
        'filters[title]': this.filters.title,
        'filters[transcriptions]': this.filters.transcriptions,
        'filters[visible]': this.filters.visible
      }).then(response => {
        // set the total rows from the response meta
        if (response.meta && response.meta.total) {
          this.totalRows = response.meta.total
        }

        if (response.included) {
          // Store all of the page_types for the result set so they can be
          this.page_types = response.included.filter(relation => {
            return relation.type === 'page_types'
          })

          // Store all of the page_days for the result set so they can be
          this.page_days = response.included.filter(relation => {
            return relation.type === 'page_days'
          })

          // Store all of the transcriptions for the result set so they can be
          this.transcriptions = response.included.filter(relation => {
            return relation.type === 'transcriptions'
          })
        }

        if (response.data) {
          // Pluck the array of pages off our axios response
          this.pages = response.data.map(page => {
            // Find the page_type for each page, and then set the page_type
            // property on the page to the page_type we found so that the page
            // rows will have access to the page_type data
            page.page_type = this.page_types.find(pageType => {
              return pageType.id === page.relationships.page_type.data.id
            })

            // Find the page_days for each page, and then
            // set the page_days property on the page to the
            // page_days we find so that the page will have access to
            // the page_day data
            const pageDayIds = page.relationships.page_days.data.map(
              pageDay => pageDay.id
            )
            // console.log(pageDayIds)
            page.page_days = this.page_days.filter(pageDay => {
              return pageDayIds.includes(pageDay.id)
            })

            // Find the transcriptions for each page, and then
            // set the transcriptions property on the page to the
            // transcriptions we find so that the page will have access to
            // the transcription data
            const transcriptionIds = page.relationships.transcriptions.data.map(
              transcription => transcription.id
            )
            // console.log(transcriptionIds)
            page.transcriptions = this.transcriptions.filter(transcription => {
              return transcriptionIds.includes(transcription.id)
            })

            return page
          })
        }

        // Must return an array of pages or an empty array if an error occurred
        return this.pages || []
      })
    },
    toggleSelectAll (checked) {
      if (checked) {
        this.$refs.table.selectAllRows()
      } else {
        this.$refs.table.clearSelected()
      }
    }
  }
}
</script>

<style scoped lang="scss">
  .pages-table {
    /deep/ th {
      vertical-align: top;

      &.selected {
        width: 105px;
        text-align: center;
      }

      &.id {
        width: 75px;

        input {
          text-align: right;
        }
      }

      > .filter {
        select {
          margin-top: 0 !important;
          min-width: 50px;
        }
      }
    }

    /deep/ td {

      &.number {
        text-align: right;
      }

      &.selected {
        text-align: center;
      }

      &.page-days {
        min-width: 150px;
      }

      &.transcriptions {
        min-width: 120px;
      }
    }
  }

  .filter {
    > .input-group-append {
      > button.btn-outline-secondary {
        border: 1px solid #ced4da;

        &:hover {
          background-color: #ced4da;
          color: #6c757d;
        }
      }
    }
  }

  .page-size-group {
    width: 110px;

    .page-size-selector {
      text-align: right;
      text-align-last: right;

      /deep/ option {
        direction: rtl;
      }
    }
  }

  .pagination {
    /deep/ li.page-item.disabled {
      span.page-link {
        padding: .4rem .9rem;
      }
    }
  }

</style>
