import React from 'react';
import PropTypes from 'prop-types';
import withStyles from 'isomorphic-style-loader/lib/withStyles';
import s from './WebServer.css';
import Base from '../../../../Base';
import Section from '../../Section';
import Code from '../../../../Code';

class WebServer extends Base {
    
    constructor(props) {
        super(props);
    }

    render() {

        return (
            <div data-e2e={this.e2e()}>
                <Section title="What you will learn">

                    <p>
                        
            <ul>
                <li>Learn how a web server works</li>
                <li>Learn html basics</li>
                <li>Learn how to add events to the dom</li>
                <li>Learn how a client communicates with a server via http </li>
                <li>Learn about the browsers DevTools</li>
            </ul>
                    </p>

                </Section>


                <Section title="Write the server and html file">

            Let's first see how a web server works.  We will write one <i>html</i> and a
            web server that serves it.

            Create new directory for this server.

                    <Code
                        text={`

$ mkdir test-server
$ cd test-sever

                    `.trim()}
                    />

            Create the html file that we will serve.

                    <Code
                        text={`

$ nano index.html

                    `.trim()}
                    />

            Write a basic html file.

                    <Code
                        text={`

<!DOCTYPE html>
<html>
    <body>
        <h1>Control LED light</h1>
        <input id="light" type="checkbox">LED
        <script>
            console.log('Hello, World!')
        </script>
    </body>
</html>

                    `.trim()}
                    />


            Create the server code.  This code will respond to http requests.

                    <Code
                        text={`

var server = require('http').createServer(handler); 
var fs = require('fs'); 

server.listen(8080); 

function handler (req, res) {
    fs.readFile(__dirname + '/index.html', function(err, data) { 
        if (err) {
            res.writeHead(404, {'Content-Type': 'text/html'}); 
            return res.end("404 Not Found");
        } 
        res.writeHead(200, {'Content-Type': 'text/html'}); 
        res.write(data); 
        return res.end();
    });
}

                    `.trim()}
                    />

    Let's run the server.
    
                    <Code
                        text={`

$ node server.js

                    `.trim()}
                    />
                </Section>               

            </div>
        );
    }
}

export default withStyles(s)(WebServer);
