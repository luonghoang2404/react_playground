{ div, h3, h4, h5, table, thead, tbody, tr, th, td, a, i, input, select, option, span, button, img } = React.DOM
@amountFormat = (amount) ->
  '$ ' + Number(amount).toLocaleString()