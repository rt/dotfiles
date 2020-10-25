import React from 'react';
import PropTypes from 'prop-types';
import withStyles from 'isomorphic-style-loader/lib/withStyles';
import s from './PushButtonLED.css';
import Base from '../../../../Base';
import Section from '../../Section';
import ConceptIntro from '../../ConceptIntro';
import Image from '../../../../Image';
import Code from '../../../../Code';

class PushButtonLED extends Base {
    
    constructor(props) {
        super(props);
    }

    render() {

        return (
            <div data-e2e={this.e2e()}>

                <Section title="What we will learn">

            We have seen the button used within a circuit be we can also use it in a separate circuit to act as a trigger to run other code.
            We will also keep track of state in the code.

                    <ul>
                        <li>bouncetime</li>
                    </ul>

                </Section>


                <Section title="Build the circuit">

                    <p>

            We could add the button to the LED circuit directly.  However, sometimes there is <i>interference</i>
            which will cause the LED to light up even when the button is off.  We can avoid this by
            using a <i>pull-down resistor</i> between the button and <i>ground</i> to consume the interference
            when the button is off.  We can detect when the button is on/off and then run the code to 
            turn the LED on/off.
                    
                    
                    </p>

                    <Image responsive="width" src="/push_button_led_bb.png" alt="Picture of a Blinking LED Breadboard" />

                </Section>

                <Section title="Write the code">

                    <Code
                        text={`

#!/usr/bin/env python
import RPi.GPIO as GPIO
import time

LedPin = 11
BtnPin = 12

Led_status = 1

def setup():
    GPIO.setmode(GPIO.BOARD)
    GPIO.setup(LedPin, GPIO.OUT)
    GPIO.setup(BtnPin, GPIO.IN, pull_up_down=GPIO.PUD_UP)
    GPIO.output(LedPin, GPIO.HIGH)

def blink(ev=None):
    global Led_status
    Led_status = not Led_status
    GPIO.output(LedPin, Led_status)
    if Led_status == 1:
        print 'LED off...'
    else:
        print '...LED on'

def loop():
    GPIO.add_event_detect(BtnPin, GPIO.FALLING, callback=blink, bouncetime=200) 
    while True:
        time.sleep(1)

def destroy():
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

export default withStyles(s)(PushButtonLED);
