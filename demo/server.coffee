sendImage = ->
  base64Image = "data:image/jpeg;base64," + btoa(updatedImage)
  io.emit "image sent", base64Image
  console.log "Sent image of " + base64Image.length + " bytes"
  return
btoa = require('btoa')
Paparazzo = require("../src/paparazzo")
app = require("express")()
http = require("http").Server(app)
io = require("socket.io")(http)

paparazzo = new Paparazzo
    host: 'plazacam.studentaffairs.duke.edu'
    port: 80
    path: '/mjpg/video.mjpg'

updatedImage = ""

paparazzo.on "update", (image) =>
    updatedImage = String(image)
    sendImage(updatedImage)

paparazzo.on 'error', (error) =>
    console.log "Error: #{error.message}"

paparazzo.start()

app.get "/", (req, res) ->
  res.sendfile "demo/demo.html"
  return

 io.on "connection", (socket) ->
  console.log "a user connected"
  return

 http.listen 3000, ->
  console.log "listening on *:3000"
  return
