import React from 'react';
import PropTypes from 'prop-types';
import withStyles from 'isomorphic-style-loader/lib/withStyles';
import s from './PwmLED.css';
import Base from '../../../../Base';
import Section from '../../Section';
import ConceptIntro from '../../ConceptIntro';
import Image from '../../../../Image';
import Code from '../../../../Code';
import Hr from '../../../../Hr';

class PwmLED extends Base {
    
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

                <Section title="Pulse Width Modulation">

                    <p>
            
            Pulse Width Modulation (PWM) is a way to get analog values when
            only on/off values are present.  Digital control is used to create
            a square wave switching a signal between on and off.  By adjusting
            the time that a signal stays on, the <i>duty cycle</i> is how
            analog values can be simulated.  A duty cycle of 60% means that 60%
            of the time the signal is ON and 40% of the time it is OFF.


                    </p>

                </Section>


                <Section title="Build the circuit">

                    <p>
                    
                    
                    </p>

                    <Image responsive="width" src="/pwm_led_bb.png" alt="Picture of a Breathing LED Breadboard" />

                </Section>

                <Section title="Write the code">

                    <Code
                        text={`

#!/usr/bin/env python
import RPi.GPIO as GPIO
import time

LedPin = 12

def setup():
	global p
	GPIO.setmode(GPIO.BOARD)
	GPIO.setup(LedPin, GPIO.OUT)
	GPIO.output(LedPin, GPIO.LOW)

	p = GPIO.PWM(LedPin, 1000)     # set Frequece to 1KHz
	p.start(0)                     # Duty Cycle = 0

def loop():
	while True:
		for dc in range(0, 101, 4):
			p.ChangeDutyCycle(dc)
			time.sleep(0.05)
		time.sleep(1)
		for dc in range(100, -1, -4):
			p.ChangeDutyCycle(dc)
			time.sleep(0.05)
		time.sleep(1)

def destroy():
	p.stop()
	GPIO.output(LedPin, GPIO.HIGH)
	GPIO.cleanup()

if __name__ == '__main__':
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

export default withStyles(s)(PwmLED);
