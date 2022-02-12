import path from 'path';
import express from 'express';
import cookieParser from 'cookie-parser';
import bodyParser from 'body-parser';
import PrettyError from 'pretty-error';
import csrf from 'csurf';
//express-session (server session)
//import session from 'express-session';
//import connectMongo from 'connect-mongo';

//client session (cookie only)
import session from 'cookie-session';
import itemV1Api from './api/item.v1';

import config from './config';

const app = express();

//init database
// let db = getDatabase();

// Tell any CSS tooling (such as Material UI) to use all vendor prefixes if the
// user agent is not known.
// -----------------------------------------------------------------------------
global.navigator = global.navigator || {};
global.navigator.userAgent = global.navigator.userAgent || 'all';

//trust reverse proxy
app.set('trust proxy', 1); // trust first proxy

// Cross-domain access
// -----------------------------------------------------------------------------
//app.options(/^\/sessions$/, function(req, res){
//res.set({
//'Access-Control-Allow-Origin': '*',
//'Access-Control-Allow-Headers': 'CSRF_TOKEN',
//});
//res.end(JSON.stringify({
//}));
//});

// Register middleware
// -----------------------------------------------------------------------------
app.use(express.static(path.join(__dirname, 'public')));
app.use(cookieParser());
app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());

//----- Session -----
// setup session mangement middlewared
// use client or server side (pick a store)
//require express-session, connect-mongo
//const MongoStore = connectMongo(session);

//app.use(session({
//secret: 'foo',
//store: new MongoStore({ url: 'mongodb://localhost:27017/testdb' })
//}));

//require cookie-session
var expiryDate = new Date(Date.now() + 60 * 60 * 1000); // 1 hour
app.use(
    session({
        name: 'session',
        keys: ['key1', 'key2'],
        cookie: {
            //secure: true,
            httpOnly: true,
            //domain: 'example.com',
            //path: 'foo/bar',
            expires: expiryDate,
        },
    })
);

//
// CSRF must declare after session middleware
// -----------------------------------------------------------------------------
//var csrfProtection = csrf({ cookie: true }); //need cookie-parser or cookie-session
//app.use(csrf());
//app.use((req, res, next) => {
////no need expiration because it changes on each request
////the other possibility is to put it in each response, dont assume cookies
//res.cookie('XSRF-TOKEN', req.csrfToken());
//next();
//});

itemV1Api(app);

app.use((req, res) =>
    res.sendFile(path.join(__dirname, 'public', 'index.html'))
);

//
// Error handling
// -----------------------------------------------------------------------------
const pe = new PrettyError();
pe.skipNodeFiles();
pe.skipPackage('express');

app.use((err, req, res, next) => {
    // eslint-disable-line no-unused-vars
    console.log(pe.render(err)); // eslint-disable-line no-console
    app.get('logger').createLog(
        'endPoint',
        'Error on endpoint',
        JSON.stringify(err, null, 2)
    );
    //const html = ReactDOM.renderToStaticMarkup(
    //<Html
    //title="Internal Server Error"
    //description={err.message}
    //style={errorPageStyle._getCss()} // eslint-disable-line no-underscore-dangle
    //>
    //{ReactDOM.renderToString(<ErrorPageWithoutStyle error={err} />)}
    //</Html>,
    //);
    res.status(err.status || 500);
    res.send(`<!doctype html>${pe.render(err)}`);
    //res.send(`<!doctype html>${html}`);
});

//
// Launch the server
// -----------------------------------------------------------------------------
/* eslint-disable no-console */
app.listen(config.port, config.ip, () => {
    console.log(`The server is running at http://${config.ip}:${config.port}/`);
});
