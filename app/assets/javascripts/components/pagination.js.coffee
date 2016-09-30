@Pagination = React.createClass
  getInitialState: ->
    current_page: 1

  changePage: (e)->
    @setState current_page: e.target.text
    @props.pageChange e.target.text

  render: ->
    if @props.total_pages < 10
      start = 1
      end = @props.total_pages
    else
      start = @props.total_pages-10
      end = @props.total_pages

    ul className: 'pagination',
      for i in [start..end]
        if i == parseInt(@state.current_page)
          li className: 'active', key: 'page' + i,
            a onClick: @changePage, i,
        else
          li key: 'page' + i,
            a onClick: @changePage, i,
