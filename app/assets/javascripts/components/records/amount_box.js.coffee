{ div, h3, h4, h5, table, thead, tbody, tr, th, td, a, i, input, select, option, span, button, img } = React.DOM
@AmountBox = React.createClass
  render: ->
    div className: 'col-md-4',
      div className: "panel panel-#{ @props.type }",
        div className: 'panel-heading', @props.text
        div className: 'panel-body', amountFormat(@props.amount)


