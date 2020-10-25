import React from 'react';
import PropTypes from 'prop-types';
import withStyles from 'isomorphic-style-loader/lib/withStyles';
import s from './PythonPrimer.css';
import Base from '../../../../Base';
import Section from '../../Section';
import Code from '../../../../Code';

class PythonPrimer extends Base {
    
    constructor(props) {
        super(props);
    }

    render() {

        return (
            <div data-e2e={this.e2e()}>

                <Section title="What you'll learn">

            <p>

            Python is an easy language to learn and is widely used.  It is one
            of, if not, the most popular languages to program Raspberry Pies.
            You will not need to know the details of Python but here we will
            just go over some of the basic things that you will see in code
            that we use.  We will be accessing the GPIO pins with Python via
            the <i>RPi.GPIO</i> module.  The Raspian OS image includes this
            module by default.  

                    </p>

                </Section>

                <Section title="Write and Run a program">

                    <Code
                        text={`

$ nano hello-world.py

                    `.trim()}
                    />

                
                    <Code
                        text={`

print("Hello, World!")


                    `.trim()}
                    />
                </Section>

                <Section title="Python Language Fundamentals">

                    <Code
                        text={`

#!/usr/bin/env python                   # Script env declaration
import RPi.GPIO as GPIO                 # Import libraries

myGlobalVariable = 12                   # Global variable

def myFunction():                       # Function
    myVariable = 1                      # Local variable

def destroy():
    GPIO.cleanup()

if __name__ == '__main__':              # The main programs start here
    setup()                             # Initialize things
    try:                                # Try to run the program
        loop()
    except KeyboardInterrupt:           # Exception handling
        destroy()

                    `.trim()}
                    />
                </Section>

                <Section title="Rapberry Pi Basic Setup">

                    <Code
                        text={`

#!/usr/bin/env python
import RPi.GPIO as GPIO

LedPin = 12

def setup():
	GPIO.setmode(GPIO.BOARD)
	GPIO.setup(LedPin, GPIO.OUT)
	GPIO.output(LedPin, GPIO.LOW)

def myProgram():
    #... 

def destroy():
	GPIO.output(LedPin, GPIO.HIGH)
	GPIO.cleanup()

if __name__ == '__main__':              # Programs start here
	setup()                             # Initialize things
	try:                                # Try to run the program
		loop()
	except KeyboardInterrupt:
		destroy()

                    `.trim()}
                    />

                </Section>


                <Section title="Running a program">

                    <Code
                        text={`

$ sudo python test-rpi.py

                    `.trim()}
                    />

                </Section>
            </div>
        );
    }
}

export default withStyles(s)(PythonPrimer);
