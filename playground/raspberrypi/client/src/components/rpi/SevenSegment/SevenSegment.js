import React from 'react';
import PropTypes from 'prop-types';
import withStyles from 'isomorphic-style-loader/lib/withStyles';
import s from './SevenSegment.css';
import Base from '../../../../Base';
import Section from '../../Section';
import ConceptIntro from '../../ConceptIntro';
import Image from '../../../../Image';
import Code from '../../../../Code';

class SevenSegment extends Base {
    
    constructor(props) {
        super(props);
    }

    render() {

        return (
            <div data-e2e={this.e2e()}>

                <Section title="What you'll learn">

                    <p>

.gfedcba
00111111
00000110
10000000
                    </p>

                </Section>

                <Section title="Components">

                    <p>

                    </p>

                    <ConceptIntro title="Seven Segment" responsive="height" image="/seven_segment.png">
                        
                        <p>


                        </p>
                        
                    </ConceptIntro>

                </Section>


                <Section title="Build the circuit">

                    <p>
                    
                    
                    </p>

                    <Image responsive="width" src="/seven_segment_bb.png" alt="Picture of seven segment component" />

                </Section>

                <Section title="Write the code">

                    <Code
                        text={`

#!/usr/bin/env python
import RPi.GPIO as GPIO
import time

SDI   = 11
RCLK  = 12
SRCLK = 13

segCode = [0x3f,0x06,0x5b,0x4f,0x66,0x6d,0x7d,0x07,0x7f,0x6f,0x77,0x7c,0x39,0x5e,0x79,0x71,0x80]

def print_msg():
	print 'Program is running...'
	print 'Please press Ctrl+C to end the program...'

def setup():
	GPIO.setmode(GPIO.BOARD)
	GPIO.setup(SDI, GPIO.OUT)
	GPIO.setup(RCLK, GPIO.OUT)
	GPIO.setup(SRCLK, GPIO.OUT)
	GPIO.output(SDI, GPIO.LOW)
	GPIO.output(RCLK, GPIO.LOW)
	GPIO.output(SRCLK, GPIO.LOW)

def hc595_shift(dat):
	for bit in range(0, 8):	
		GPIO.output(SDI, 0x80 & (dat << bit))
		GPIO.output(SRCLK, GPIO.HIGH)
		time.sleep(0.001)
		GPIO.output(SRCLK, GPIO.LOW)
	GPIO.output(RCLK, GPIO.HIGH)
	time.sleep(0.001)
	GPIO.output(RCLK, GPIO.LOW)

def loop():
	while True:
		for i in range(0, len(segCode)):
			hc595_shift(segCode[i])
			time.sleep(0.5)

def destroy():
	GPIO.cleanup()

if __name__ == '__main__':
	print_msg()
	setup() 
	try:
		loop()  
	except KeyboardInterrupt:  
		destroy()  

                    `.trim()}
                    />

                </Section>
            </div>
        );
    }
}

export default withStyles(s)(SevenSegment);
