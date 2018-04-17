require('./css/index.scss')

const Elm = require('./Main.elm')

const app = Elm.Main.embed(document.getElementById('main'))

const sampleStudents = [{
    firstName: "Bill",
    lastName: 'E',
    birthdate: '2012-5-12',
    sex: 'M'
  },
  {
    firstName: "Sall",
    lastName: 'E',
    birthdate: "2014-4-5",
    sex: 'F'
  }
]

// Pass in people
app.ports.loadUsers.send(sampleStudents)