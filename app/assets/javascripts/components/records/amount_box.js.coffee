@AmountBox = React.createClass
  render: ->
    div className: 'col-md-4',
      div className: "panel panel-#{ @props.type }",
        div className: 'panel-heading', @props.text
        div className: 'panel-body', amountFormat(@props.amount)


