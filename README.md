Paparazzo.js
-

_A stalker of [IP cameras](http://en.wikipedia.org/wiki/IP_camera)_

[![endorse](http://api.coderwall.com/wilhelmbot/endorsecount.png)](http://coderwall.com/wilhelmbot)

**What is this?**

A high performance web proxy for serving [MJPG](http://en.wikipedia.org/wiki/Motion_JPEG) streams to the masses.

IPCamera (1) <-> (1) Paparazzo.js (1) <-> (N) Users

![Demo screenshot](https://github.com/wilhelmbot/Paparazzo.js/raw/master/mjpg_demo.gif "Streaming a VIVOTEK camera")

Background
-

**IP cameras can't handle web traffic**

IP cameras are slow devices that can't handle a regular amount of web traffic. So if you plan to go public with an IP camera you have the following options:

1. **The naive approach** - Embed the camera service directly in your site, e.g. http://201.166.63.44/axis-cgi/jpg/image.cgi?resolution=CIF.
2. **Ye olde approach** - Serve images as static files in your server. I've found that several sites use this approach through messy PHP background jobs that update this files at slow intervals, generating excessive (and unnecessary) disk accesses.
3. **Plug n' pray approach** - Embed a flash or Java-based player, such as the  [Cambozola](http://www.charliemouse.com/code/cambozola/) player. This requires plugins.
4. **MJPG proxy** - Serve the MJPG stream directly if you are targeting only grade A browsers, (sorry IE).
5. **Paparazzo.js: A web service of dynamic images** - Build a MJPG proxy server which parses the stream, updates images in memory, and delivers new images on demand. I've found that this approach is scalable, elegant, blazing fast and doesn't require disk access.

Usage
-

**Server side**

```coffeescript
# Initialize

# Same parameters as http.get http://nodejs.org/docs/v0.6.0/api/http.html#http.get
paparazzo = new Paparazzo 
  host: 'camera.dyndns.org'
  port: 1881
  path: '/mjpg/video.mjpg'
  headers: { 'Authorization': auth }

paparazzo.on "update", (image) =>
    updatedImage = String(image)
    sendImage(updatedImage)

paparazzo.on 'error', (error) => 
  console.log "Error: #{error.message}"

paparazzo.start()

# Serve image
# Take a look at server.coffee
```

**Client side**

You can simulate MJPG streaming by updating an IMG SRC with a base64 encoded JPEG sent on a specific socket event:

```javascript
// JavaScript example using jQuery

var socket = io();
			$(document).ready(function() {
				socket.on("image sent", function (base64Image) {
					$('img#camera').attr('src', base64Image);
				});
			});	
```

```html
<!-- In your HTML output -->
<img src='' id='camera' />
```

Demo
-
	$ make run

For a list of tested cameras check ["List of tested
cameras"](https://github.com/rodowi/Paparazzo.js/wiki/List-of-tested-cameras) in the wiki
section.

Implemented features in this fork:
-  
* Websockets implementation to get more FPS

TODO
-  
* More tests
* Find more public cameras to test

License  
-  

<a rel="license" href="http://opensource.org/licenses/MIT">The MIT License (MIT)</a>

Copyright (c) 2014 Rodolfo Wilhelmy <[rod@wilhel.me](mailto:rod@wilhel.me)><br>
Copyright (c) 2014 YouView TV Ltd <[colin.robertson@youview.com](mailto:colin.robertson@youview.com)>
