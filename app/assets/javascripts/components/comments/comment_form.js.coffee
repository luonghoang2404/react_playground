R = React.DOM
@CommentForm = React.createClass
  getInitialState: ->
    author: ''
    text: ''
  handleChange: (e) ->
    name = e.target.name
    @setState "#{ name}": e.target.value
  valid: ->
    @state.author && @state.text
  handleSubmit: (e) ->
    e.preventDefault()
    $.ajax
      url: '/comments'
      dataType: 'json'
      type: 'POST'
      data: {comment: @state}
      success: ((data) ->
        @setState @getInitialState()
        @props.onCommentSubmit data
        ).bind(this)
      error : ((xhr, status, err) ->
        console.error @props.url, status, err.toString()
        return
        ).bind(this)

  render: ->
    R.form
      className: 'commentForm'
      onSubmit: @handleSubmit
      R.input
        type: 'text'
        placeholder: 'Your Name'
        value: @state.author
        name: 'author'
        onChange: @handleChange
      R.input
        type: 'text'
        placeholder: 'Say something...'
        value: @state.text
        name: 'text'
        onChange: @handleChange
      R.input
        type: 'submit'
        disabled: !@valid()
        value: 'Post'
