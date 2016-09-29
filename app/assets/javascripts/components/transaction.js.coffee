{ div, h3, h4, h5, table, thead, tbody, tr, th, td, a, i, input, select, option, span, button, img } = React.DOM
R = React.DOM
RC = React.createElement

@Checkbox = React.createClass
  getInitialState: ->
    share: 1
    base: @props.base
    tick: ''

  handleChangeShare: (e)->
    new_value = e.target.value
    if new_value >= 0
      old_value = @state.share
      diff = new_value - old_value
      @setState share: new_value
      @props.setShare diff

  handleTick: (e)->
    if @state.tick == ''
      @setState tick: 'checked'
    else
      @setState tick: "", share: 0
  render: ->
    R.tr null,
      R.td null,
        R.label null,
          @props.name
      
      R.td null,
        if @props.advanced
          R.input
            className: 'pull-right btn-block'
            type:'number'
            value: @state.share
            placeholder: 'Share'
            onChange: @handleChangeShare
      R.td null,
        R.input
          className: 'pull-right btn-block'
          type:'number'
          value: @props.base * @state.share
          placeholder: 'Amount'
          onChange: @handleChange


@Transaction = React.createClass
  getInitialState: ->
    advanced: false
    amount: 100
    split: 4
    payers: []
    payers_amount: []
    payees: []
    payees_share: []
    categories: ''
    group_id: ''
    note: ''


  componentDidMount: ->
    @setState base_amount: @state.amount/@state.split

  handleClick: (e)->
    e.preventDefault()

  changeAmount: (e)->
    @setState amount: e.target.value
    @setState base_amount: e.target.value/@state.split

  handleShare: (e)->
    split = parseInt @state.split
    diff = parseInt e
    amount = split + diff
    @setState split: amount
    if amount == 0
      @setState base_amount: 0
    else
      @setState base_amount: @state.amount / amount

  toggleAdvance: (e)->
    e.preventDefault()
    @setState advanced: !@state.advanced

  render: ->
    R.form
      className: 'box new-entry-form entry-form'
      R.div
        className: 'form-group'
        R.label
          className: 'control-label'
          'What for?'
        R.input
          className: 'form-control'
          type: 'text'
          value: ''
          onChange: @handleChange
      R.div
        className: 'form-group'
        R.label
          className: 'control-label'
          'How much?'
        R.div
          className: 'input-group'
          R.div
            className: 'input-group-addon'
            R.span
              className: 'currency-symbol'
              'đ'
          R.input
            className: 'form-control'
            type: 'number'
            value: @state.amount
            onChange: @changeAmount
      R.div
        className: 'form-group'
        R.label
          className: 'control-label'
          'Split between:'
        R.button
          className: 'btn btn-default btn-info pull-right btn-xs'
          onClick: @toggleAdvance
          if @state.advanced
            'Simple'
          else
            'Advanced'
        R.div
          className: 'checkbox'
          R.table
            className: 'table table-condensed'
            R.tbody null,
              RC Checkbox, name: 'Hoang', advanced: @state.advanced, base: @state.base_amount, setShare: @handleShare
              RC Checkbox, name: 'Huy', advanced: @state.advanced, base: @state.base_amount, setShare: @handleShare
              RC Checkbox, name: 'Trung', advanced: @state.advanced, base: @state.base_amount, setShare: @handleShare
              RC Checkbox, name: 'Thien', advanced: @state.advanced, base: @state.base_amount, setShare: @handleShare
            
        
