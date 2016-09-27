R = React.DOM
RC = React.createElement
@CommentBox = React.createClass
  getInitialState: ->
    comments: []
  # componentDidMount: ->
  loadCommentFromServer: ->
    $.ajax
      url: @props.url
      dataType: 'json'
      cache: false
      success: ((data) ->
        @setState comments: data
        return
        ).bind(this)
      error: ((xhr, status, err) ->
        console.error @props.url, status, err.toString()
        return
        ).bind(this)

  componentDidMount: ->
    @loadCommentFromServer()
  #   # setInterval @loadCommentFromServer, @props.pollInterval

  handleCommentSubmit: (comment) ->
    comments = @state.comments.slice()
    comments.push comment
    @setState comments: comments

  handleDeleteComment: (comment) ->
    @loadCommentFromServer()
    # alert 'delete'
    # comments = @state.comments
    # index = comments.indexOf comment
    # comments.splice(0, index)
    # @setState comments: comments

  render: ->
    R.div
      className: 'commentBox'
      R.h1 null,
        "Hello World"
      RC CommentList, comments: @state.comments, deleteComment: @handleDeleteComment
      RC CommentForm, onCommentSubmit: @handleCommentSubmit
