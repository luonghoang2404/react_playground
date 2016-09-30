@Records = React.createClass
  getInitialState: ->
    records: @props.data

  getDefaultProps: ->
    records: []

  credits: ->
    credits = @state.records.filter (val) -> val.amount >= 0
    credits.reduce ((prev, curr) ->
      prev + parseFloat(curr.amount)
    ), 0

  debits: ->
    debits = @state.records.filter (val) -> val.amount < 0
    debits.reduce ((prev, curr) ->
      prev + parseFloat(curr.amount)
    ), 0

  balance: ->
    @debits() + @credits()

  addRecord: (record) ->
    records = React.addons.update(@state.records, { $push: [record] })
    @setState records: records

  deleteRecord: (record) ->
    index = @state.records.indexOf record
    records = React.addons.update(@state.records, { $splice: [[index, 1]] })
    @replaceState records: records

  updateRecord: (record, data) ->
    index = @state.records.indexOf record
    records = React.addons.update(@state.records, { $splice: [[index, 1, data]] })
    @replaceState records: records

  render: -> 
    div className: 'records',
      h2 className: 'title', 'Records',
      div className: 'row',
        RC AmountBox, type: 'success', amount: @credits(), text: 'Credit'
        RC AmountBox, type: 'danger', amount: @debits(), text: 'Debit'
        RC AmountBox, type: 'info', amount: @balance(), text: 'Balance'
      RC RecordForm, handleNewRecord: @addRecord
      hr null
      table className: 'table table-striped',
        thead null,
          tr className: 'info',
            th null, 'Date'
            th null, 'Title'
            th null, 'Amount'
            th null, 'Actions'
        tbody null,
          for record in @state.records
            RC Record, key: record.id, record: record, handleDeleteRecord: @deleteRecord, handleEditRecord: @updateRecord
