import React from 'react';
import PropTypes from 'prop-types';
import withStyles from 'isomorphic-style-loader/lib/withStyles';
import s from './WebSockets.css';
import Base from '../../../../Base';
import Section from '../../Section';
import Image from '../../../../Image';
import Code from '../../../../Code';

class WebSockets extends Base {
    
    constructor(props) {
        super(props);
    }

    render() {

        return (
            <div data-e2e={this.e2e()}>
                <Section title="What you will learn">

                    <p>
                        
            <ul>
                <li>Learn how a client communicates with a server via websockets</li>
            </ul>
                    </p>

                </Section>


                <Section title="Adding websockets">

    Websockets allows us to <i>push</i> data from the server to the client without the client having to request first.

                    <Code
                        text={`

const WebSocket = require('ws');
const wss = new WebSocket.Server({
  port: 8081,
});

//When a client connects
wss.on('connection', function connection(ws) {

  ws.on('message', function incoming(message) {
    console.log('received: %s', message);
  });
  ws.send('something');

});


                    `.trim()}
                    />

                </Section>               

                <Section title="index.html">

                    <Code
                        text={`

<!DOCTYPE html>
<html>
<body>
<h1>Control LED light</h1>
<p><input type="checkbox" id="light"></p>
<script>

window.addEventListener("load", function(){ //when page loads
  var lightbox = document.getElementById("light");
  lightbox.addEventListener("change", function() { //add event listener for when checkbox changes
    socket.emit("light", Number(this.checked)); //send button status to server (as 1 or 0)
  });
});
// Create WebSocket connection.
const socket = new WebSocket('ws://student2.local:8081');

// Connection opened
socket.addEventListener('open', function (event) {
            socket.send('Hello Server!');
});

// Listen for messages
socket.addEventListener('message', function (event) {
            console.log('Message from server ', event.data);
});



                    `.trim()}
                    />

                </Section>               



                <Section title="Python client">
https://github.com/websocket-client/websocket-client
                    <Code
                        text={`

import websocket
try:
    import thread
except ImportError:
    import _thread as thread
import time

def on_message(ws, message):
    print(message)

def on_error(ws, error):
    print(error)

def on_close(ws):
    print("### closed ###")

def on_open(ws):
    def run(*args):
        for i in range(3):
            time.sleep(1)
            ws.send("Hello %d" % i)
        time.sleep(1)
        ws.close()
        print("thread terminating...")
    thread.start_new_thread(run, ())


if __name__ == "__main__":
    websocket.enableTrace(True)
    ws = websocket.WebSocketApp("ws://0.0.0.0:8081/",
                              on_message = on_message,
                              on_error = on_error,
                              on_close = on_close)
    ws.on_open = on_open
    ws.run_forever()

                    `.trim()}
                    />

                </Section>               

            </div>
        );
    }
}

export default withStyles(s)(WebSockets);
