import React from 'react';
import PropTypes from 'prop-types';
import withStyles from 'isomorphic-style-loader/lib/withStyles';
import s from './FlowingLEDs.css';
import Base from '../../../../Base';
import Section from '../../Section';
import Image from '../../../../Image';
import Code from '../../../../Code';

class FlowingLEDs extends Base {
    
    constructor(props) {
        super(props);
    }

    render() {

        return (
            <div data-e2e={this.e2e()}>
                <Section title="What we will learn">

                <p>
                    

                </p>

                </Section>

                <Section title="Build the circuit">

                <p>
                    

                </p>

                    <Image responsive="width" src="/flowing_leds_bb.png" alt="Picture of a Blinking LED Breadboard" />
                </Section>

                <Section title="Write the code">

                    <Code
                        text={`

#!/usr/bin/env python
import RPi.GPIO as GPIO
import time

pins = [11, 12, 13, 15, 16, 18, 22, 7]

def setup():
	GPIO.setmode(GPIO.BOARD)
	for pin in pins:
		GPIO.setup(pin, GPIO.OUT)
		GPIO.output(pin, GPIO.HIGH)

def loop():
	while True:
		for pin in pins:
			GPIO.output(pin, GPIO.LOW)
			time.sleep(0.05)
			GPIO.output(pin, GPIO.HIGH)
		for pin in reversed(pins):
			GPIO.output(pin, GPIO.LOW)
			time.sleep(0.05)
			GPIO.output(pin, GPIO.HIGH)

def destroy():
	for pin in pins:
		GPIO.output(pin, GPIO.HIGH)
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

export default withStyles(s)(FlowingLEDs);
