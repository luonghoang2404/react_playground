R = React.DOM
RC = React.createElement
@CommentList = React.createClass

  handleDeleteComment: (comment) ->
    @props.deleteComment comment

  render: ->
    R.div
      className: 'commentList'
      for comment in @props.comments
        RC Comment, key: comment.id, comment: comment, deleteComment: @handleDeleteComment
