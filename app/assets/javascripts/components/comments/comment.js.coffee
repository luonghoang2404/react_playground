R = React.DOM
RC = React.createElement
@Comment = React.createClass

  handleDelete: (e)->
    e.preventDefault()
    $.ajax
      type: 'DELETE'
      url: "/comments/#{@props.comment.id}"
      @props.deleteComment @props.comment

  render: ->
    R.div
      className:"comment"
      R.h2
        className:"commentAuthor"
        @props.comment.author
      @props.comment.text
      R.a
        onClick: @handleDelete
        "Delete"
