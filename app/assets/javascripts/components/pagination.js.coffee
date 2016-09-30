@Pagination = React.createClass
  getInitialState: ->
    current_page: 1

  changePage: (e)->
    @setState current_page: e.target.text
    @props.pageChange e.target.text

  render: ->
    ul className: 'pagination',
      for i in [1..@props.total_pages]
        if i == parseInt(@state.current_page)
          li className: 'active', key: i,
            a onClick: @changePage, i,
        else
          li key: i,
            a onClick: @changePage, i,
