import React from 'react';
import PropTypes from 'prop-types';
import withStyles from 'isomorphic-style-loader/lib/withStyles';
import s from './RotaryEncoder.css';
import Base from '../../../../Base';
import Section from '../../Section';
import ConceptIntro from '../../ConceptIntro';
import Image from '../../../../Image';
import Code from '../../../../Code';

class RotaryEncoder extends Base {
    
    constructor(props) {
        super(props);
    }

    render() {

        return (
            <div data-e2e={this.e2e()}>

                <Section title="What you'll learn">

                    <p>

                    </p>

                </Section>

                <Section title="Components">

                    <p>

                    </p>

                    <ConceptIntro title="Rotary Encoder" responsive="height" image="/rotary_encoder.png">
                        
                        <p>

            A rotary encoder has a fixed number of positions per revolution.
            Inside, there are two pins which in each position they are
            either both closed or open.  These internal pins, A and B,  are next to each other so that 
            when you rotate clockwise the A pin will connect/contact first.  Rotating counterclockwise will
            make the B pin connect/contact first.  With this information we can determine the direction

                        </p>
                        
                    </ConceptIntro>

                </Section>


                <Section title="Build the circuit">

                    <p>
                    
            The pins are labeled on the rotary encoder.  Connect the rotary encoder via the breadboard to the 
            Raspberry Pi pins as follows.
                    
                    </p>

                    <table>
                        <thead>
                            <tr><td>Raspberry Pi</td><td>Rotary Encoder</td></tr>
                        </thead>
                        <tbody>
                            <tr><td>3.3V</td><td>+</td></tr>
                            <tr><td>GND</td><td>GND</td></tr>
                            <tr><td>GPIO0</td><td>DT</td></tr>
                            <tr><td>GPIO1</td><td>CLK</td></tr>
                        </tbody>
                    </table>

                </Section>

                <Section title="Write the code">

                    <Code
                        text={`

#!/usr/bin/env python
import RPi.GPIO as GPIO
import time

RoAPin = 11
RoBPin = 12
RoSPin = 13

globalCounter = 0

flag = 0
Last_RoB_Status = 0
Current_RoB_Status = 0

def setup():
	GPIO.setmode(GPIO.BOARD)
	GPIO.setup(RoAPin, GPIO.IN)
	GPIO.setup(RoBPin, GPIO.IN)
	GPIO.setup(RoSPin,GPIO.IN,pull_up_down=GPIO.PUD_UP)
	rotaryClear()

def rotaryDeal():
	global flag
	global Last_RoB_Status
	global Current_RoB_Status
	global globalCounter
	Last_RoB_Status = GPIO.input(RoBPin)
	while(not GPIO.input(RoAPin)):
		Current_RoB_Status = GPIO.input(RoBPin)
		flag = 1
	if flag == 1:
		flag = 0
		if (Last_RoB_Status == 0) and (Current_RoB_Status == 1):
			globalCounter = globalCounter + 1
			print 'globalCounter = %d' % globalCounter
		if (Last_RoB_Status == 1) and (Current_RoB_Status == 0):
			globalCounter = globalCounter - 1
			print 'globalCounter = %d' % globalCounter

def clear(ev=None):
        globalCounter = 0
	print 'globalCounter = %d' % globalCounter
	time.sleep(1)

def rotaryClear():
        GPIO.add_event_detect(RoSPin, GPIO.FALLING, callback=clear) 


def loop():
	global globalCounter
	while True:
		rotaryDeal()

def destroy():
	GPIO.cleanup()

if __name__ == '__main__':
	setup()
	try:
		loop()
	except KeyboardInterrupt:
		destroy()

# another possibility (simple, but maybe has errors?)
# from RPi import GPIO
# from time import sleep

# clk = 17
# dt = 18

# GPIO.setmode(GPIO.BCM)
# GPIO.setup(clk, GPIO.IN, pull_up_down=GPIO.PUD_DOWN)
# GPIO.setup(dt, GPIO.IN, pull_up_down=GPIO.PUD_DOWN)

# counter = 0
# clkLastState = GPIO.input(clk)

# try:

        # while True:
                # clkState = GPIO.input(clk)
                # dtState = GPIO.input(dt)
                # if clkState != clkLastState:
                        # if dtState != clkState:
                                # counter += 1
                        # else:
                                # counter -= 1
                        # print counter
                # clkLastState = clkState
                # sleep(0.01)
# finally:
        # GPIO.cleanup()

                    `.trim()}
                    />

                </Section>
            </div>
        );
    }
}

export default withStyles(s)(RotaryEncoder);
