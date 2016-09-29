# {PropTypes} = React
# { div, h3, h4, h5, table, tbody, tr, td, a, i, input, select, option, span, button, img } = React.DOM

# window.ScoreSheet = React.createClass
#   propTypes:
#     exam: PropTypes.object
#     questions: PropTypes.array
#     studentAnswers: PropTypes.array
#     studentExams: PropTypes.array
#     users: PropTypes.array
#     currentUser: PropTypes.object

#   getInitialState: ->
#     {
#       studentAnswers: @props.studentAnswers
#       studentExams: @props.studentExams
#       studentIdActive: ''
#       activeQuestion: ''
#     }

#   componentWillMount: ->
#     document.addEventListener('keyup', @onKeyUp)
#     document.addEventListener('keydown', @onKeyDown)

#   componentWillUnmount: ->
#     document.removeEventListener('keyup', @onKeyUp)
#     document.removeEventListener('keydown', @onKeyDown)

#   componentDidMount: ->
#     if @props.currentUser.user_type.type_name is 'Student' and !@state.studentIdActive
#       sectionSequence = @sectionSequence(@props.currentUser.id).sectionSequence
#       nextRow = sectionSequence[0]

#       studentExam = _.find(@state.studentExams, { student_id: @props.currentUser.id })
#       unless studentExam
#         $.ajax
#           type: 'POST'
#           url: '/student_exams'
#           queue: true
#           data:
#             student_exam:
#               student_id: @props.currentUser.id
#               exam_id: @props.exam.id
#               exam_score: 0
#           success: (response) =>
#             studentExam = response
#             {studentExams} = @state
#             studentExams.push(studentExam)
#             @setState(studentExams: studentExams, studentIdActive: @props.currentUser.id, activeQuestion: nextRow)
#           error: =>
#             # TODO: Handler
#       else
#         @setState(studentIdActive: @props.currentUser.id, activeQuestion: nextRow)

#   sortQuestions: ->
#     {questions} = @props
#     questions = _.clone(questions)
#     questions.sort (a, b) ->
#       if a.section.sequence == b.section.sequence
#         return a.sequence - b.sequence
#       else
#         return a.section.sequence - b.section.sequence
#     questions

#   render: ->
#     {exam} = @props
#     renderedTable = @renderTable()

#     div {},
#       div className: 'wrapper wrapper-content animated fadeInUp col-content',
#         div className: 'ibox-content',
#           div className: 'row',
#             div className: 'col-sm-6',
#               h3 className: 'bold',
#                 @props.exam.exam_code
#                 ' - '
#                 @props.exam.exam_name
#               h5 {},
#                 'status : '
#                 span className: 'bold',
#                   exam.exam_status.description
#             div className: 'col-sm-6',
#               unless @props.currentUser.user_type.type_name is 'Student'
#                 div className: 'input-group',
#                   span
#                     className: 'input-group-addon'
#                     'Select Student'
#                   select
#                     ref: 'selectStudent'
#                     onChange: @selectStudentOnChange
#                     className: 'form-control'
#                     option
#                       value: 'null'
#                       ''
#                     @props.users.map (user) =>
#                       option
#                         key: user.id
#                         value: user.id
#                         "#{user.first_name} #{user.last_name}"
#               else
#                 div {},
#                   div
#                     className: 'pull-right'
#                     style: width: '50px'
#                     img
#                       style:
#                         width: '50px'
#                         height: '50px'
#                       className: 'img-circle'
#                       src: @props.currentUser.profile_picture_url
#                   div
#                     className: 'pull-right text-right'
#                     style: padding: '5px 10px'
#                     h3
#                       style:
#                         paddingTop: '5px'
#                         margin: '0px'
#                       @props.currentUser.full_name
#                     h5
#                       style:
#                         paddingTop: '5px'
#                         margin: '0px'
#                       @props.currentUser.user_type.type_name

#         # Scoresheet list
#         div className: 'ibox-content',
#           div className: 'auto-scroll',
#             renderedTable

#   renderTable: ->
#     questions = @sortQuestions()

#     sectionIds = []
#     sectionId = ''
#     for question in questions
#       unless sectionId is question.section.id
#         sectionId = question.section.id
#         sectionIds.push(question.section)

#     questionSection = []
#     for sectionId in sectionIds
#       _questions = _.filter(questions, (q) -> q.section.id == sectionId.id)

#       questionBlocks = _.chunk(_questions, 5)
#       totalBlockRows = Math.ceil(questionBlocks.length / 4)

#       div {},
#         table className: 'table',
#           tbody {},
#             tr {},
#               td className: 'bg-info',
#                 h4 {},
#                   'Section '
#                   if sectionId.sequence
#                     "##{sectionId.sequence}"
#                   ': '
#                   span className: 'bold',
#                     sectionId.section_name

#         for row in [0...totalBlockRows]
#           for col in [0...4]
#             div className: 'col-sm-3',
#               @renderBlock(questionBlocks[col * totalBlockRows + row], (col * totalBlockRows * 5 + row * 5 + 1))

#   renderBlock: (questions, startRow) ->
#     renderedRows = []
#     if questions
#       renderedBlockHeader = @renderBlockHeader()
#     else
#       renderedBlockHeader = @renderBlockNullRow()

#     for i in [0...5]
#       row = startRow + i
#       question = questions?[i]
#       if question
#         renderedRow = @renderBlockRow(question, row)
#       else
#         renderedRow = @renderBlockNullRow(question, row)
#       renderedRows.push(renderedRow)

#     <table className='table text-center bold table-scoresheet-block'>
#       <tbody>
#         {renderedBlockHeader}
#         {renderedRows}
#         {renderedBlockHeader}
#       </tbody>
#     </table>

#   renderBlockHeader: ->
#     <tr>
#       <td></td>
#       <td>A</td>
#       <td>B</td>
#       <td>C</td>
#       <td>D</td>
#       <td>E</td>
#     </tr>

#   renderBlockRow: (question, row) ->
#     {studentAnswers, studentExams, studentIdActive} = @state
#     {exam} = @props

#     onClick = @onClickChoice.bind(@, question)

#     value = ''
#     studentExam = _.find(studentExams, { student_id: studentIdActive })
#     if studentExam
#       studentAnswer = _.find(studentAnswers, { student_exam_id: studentExam.id, question_id: question.id })
#       if studentAnswer
#         value = studentAnswer.student_answer_key

#     if studentIdActive
#       disabled = false
#     else
#       disabled = true

#     unless exam.exam_status.status is 102
#       disabled = true

#     if @state.activeQuestion is question
#       trBorderGlow = 'bg-primary'

#     <tr className={trBorderGlow} onClick={@onClickRow.bind(@, question)} id={question.id}>
#       <td>{question.sequence}.</td>
#       <td><input type='radio' value='A' checked={value == 'A'} disabled={disabled} onClick={onClick} /></td>
#       <td><input type='radio' value='B' checked={value == 'B'} disabled={disabled} onClick={onClick} /></td>
#       <td><input type='radio' value='C' checked={value == 'C'} disabled={disabled} onClick={onClick} /></td>
#       <td><input type='radio' value='D' checked={value == 'D'} disabled={disabled} onClick={onClick} /></td>
#       <td><input type='radio' value='E' checked={value == 'E'} disabled={disabled} onClick={onClick} /></td>
#     </tr>

#   renderBlockNullRow: ->
#     <tr>
#       <td>&nbsp;</td>
#       <td></td>
#       <td></td>
#       <td></td>
#       <td></td>
#       <td></td>
#     </tr>

#   sectionSequence: (studentId)->
#     {exam} = @props
#     {studentAnswers, studentExams} = @state

#     questions = @sortQuestions()

#     sectionIds = []
#     sectionId = ''
#     for question in questions
#       unless sectionId is question.section.id..