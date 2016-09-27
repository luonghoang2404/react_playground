R = React.DOM
RC = React.createElement
@Filter = React.createClass
  getInitialState: ->
    selected: @props.selected
  handleFilter: (e)->
    @setState selected: e.target.value
    @props.changeFilter e.target.value
  render: ->
    R.div
      className: 'form-inline'
      R.div
        className: 'form-group'
        R.input 
          className: 'form-control'
          value: 'Filter Department'
          disabled: true
        R.select
          className: 'form-control'
          onChange: @handleFilter
          value: @state.selected
          for d, index in @props.data
            R.option 
              key: d.id
              value: d.name
              d.name

