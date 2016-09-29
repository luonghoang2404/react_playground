{ div, h3, h4, h5, table, thead, tbody, tr, th, td, a, i, input, select, option, span, button, img } = React.DOM

RC = React.createElement
@Filter = React.createClass
  getInitialState: ->
    selected: @props.selected
  handleFilter: (e)->
    @setState selected: e.target.value
    @props.changeFilter e.target.value
  render: ->
    div className: 'form-inline',
      div className: 'form-group',
        input 
          className: 'form-control'
          value: 'Filter Department'
          disabled: true
        select className: 'form-control', onChange: @handleFilter, value: @state.selected,
          for d, index in @props.data
            option key: d.id, value: d.name, d.name

