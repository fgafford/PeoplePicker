require('./css/index.scss')

const Elm = require('./Main.elm')

const app = Elm.Main.embed(document.getElementById('main'))

const sampleStudents = [{
    firstName: "Barny",
    lastName: 'Rubble',
    birthdate: '1984-5-12',
    sex: 'M'
  },
  {
    firstName: "Betty",
    lastName: 'Rubble',
    birthdate: "1985-4-5",
    sex: 'F'
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
    birthdate: "1976-5-25",
    sex: 'Male'
  },
  {
    firstName: "Mr.",
    lastName: 'Slate',
    birthdate: "1971-1-2",
    sex: 'Male'
  },
  // Young
  {
    firstName: "Bamm-Bamm",
    lastName: 'Flintstone',
    birthdate: "2014-10-21",
    sex: 'Male'
  },
  {
    firstName: "Roxy",
    lastName: 'Rubble',
    birthdate: "2017-10-23",
    sex: 'Male'
  },
  {
    firstName: "Pebbles",
    lastName: 'Flinstone',
    birthdate: "2015-1-2",
    sex: 'F'
  },
  {
    firstName: "Dino",
    lastName: 'Flinstone',
    birthdate: "2010-1-2",
    sex: 'Male'
  }
]

// Pass in people
app.ports.loadUsers.send(sampleStudents)