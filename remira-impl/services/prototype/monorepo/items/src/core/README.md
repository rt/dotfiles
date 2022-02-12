## Core 

The core is the business layer of the backend and is used to access the core
functionality of the app.  It uses the Data Layer to connected to data stores.

## App Specific Architecture

>> impl-start (appSpecificArch) -using-default
>> impl-end

#### Exception Handling

Core throws errors to be caught
Api uses cored and returns error codes for client side to handle/display nicely
Api also would server log these errors

Uncaught errors would display routes/ErrorPage and also server log
However, if all api routes handle errors with error codes, it shouldn't happen

Logging errors is a utility (doesn't have to be in core, probably should change this later) 

