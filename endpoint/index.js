'use strict'

const express = require('express')
const app = express()
const exec = require('child_process').exec

app.get('/button', function (req, res) {
  res.set('Content-Type', 'text/plain')
  res.send('OK')
  console.log('Button pushed', new Date());
  exec('../main.sh');
})

app.listen(3000, function (err) {
  if (err) {
    throw err
  }

  console.log('Server started on port 3000', new Date())
})
