@Row = React.createClass
  render: ->
    tr null,
      for item, index in @props.data
        td key: index,
          h4 null, item,
