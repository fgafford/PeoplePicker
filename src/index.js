require('./css/index.scss')

const Elm = require('./Main.elm')

const app = Elm.Main.embed(document.getElementById('main'))

const sampleStudents = [{
    firstName: "Bill",
    lastName: 'E',
    birthdate: (new Date()).getTime(),
    sex: 'M'
  },
  {
    firstName: "Sall",
    lastName: 'E',
    birthdate: (new Date()).getTime(),
    sex: 'F'
  }
]

// Pass in people
app.ports.loadUsers.send(sampleStudents)