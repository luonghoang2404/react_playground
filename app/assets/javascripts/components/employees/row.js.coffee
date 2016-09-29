{ div, h3, h4, h5, table, thead, tbody, tr, th, td, a, i, input, select, option, span, button, img } = React.DOM
RC = React.createElement
@Row = React.createClass
  render: ->
    tr null,
      for item, index in @props.data
        td key: index,
          h4 null, item,
