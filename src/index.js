require('./css/index.scss')

const Elm = require('./Main.elm')

const app = Elm.Main.embed(document.getElementById('main'))

const sampleStudents = [{
    firstName: "Barny",
    lastName: 'Rubble',
    birthdate: '2012-5-12',
    sex: 'M'
  },
  {
    firstName: "Betty",
    lastName: 'Rubble',
    birthdate: "2014-4-5",
    sex: 'F'
  },
  {
    firstName: "Bamm-Bamm",
    lastName: 'Flintstone',
    birthdate: "1978-1-2",
    sex: 'Male'
  },
  {
    firstName: "Fred",
    lastName: 'Flintstone',
    birthdate: "1978-1-2",
    sex: 'Male'
  },
  {
    firstName: "Wilma",
    lastName: 'Flintstone',
    birthdate: "1978-1-2",
    sex: 'Male'
  },
  {
    firstName: "Mr.",
    lastName: 'Slate',
    birthdate: "1971-1-2",
    sex: 'Male'
  }
]

// Pass in people
app.ports.loadUsers.send(sampleStudents)