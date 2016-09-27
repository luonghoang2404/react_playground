R = React.DOM
RC = React.createElement
@Row = React.createClass
  render: ->
    R.tr null,
      for item, index in @props.data
        R.td
          key: index
          R.h6 null,
            item
