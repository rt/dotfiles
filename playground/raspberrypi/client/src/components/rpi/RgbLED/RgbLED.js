import React from 'react';
import PropTypes from 'prop-types';
import withStyles from 'isomorphic-style-loader/lib/withStyles';
import s from './RgbLED.css';
import Base from '../../../../Base';
import Section from '../../Section';
import ConceptIntro from '../../ConceptIntro';
import Image from '../../../../Image';
import Code from '../../../../Code';
import Hr from '../../../../Hr';

class RgbLED extends Base {
    
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

                    <ConceptIntro title="Rgb LED" responsive="height" image="/rgb_led.png">
                        
                        <p>


                        </p>
                        
                    </ConceptIntro>

                </Section>
                
                <Section title="Color">

                    <p>

- Hexadecimal
- Color components
                
                    </p>


                </Section>


                <Section title="Build the circuit">

                    <p>
                    
                    
                    </p>

                    <Image responsive="width" src="/rgb_led_bb.png" alt="Picture of a Rgb LED Breadboard" />

                </Section>

                <Section title="Write the code">

                    <Code
                        text={`

#!/usr/bin/env python
import RPi.GPIO as GPIO
import time

colors = [0xFF0000, 0x00FF00, 0x0000FF, 0xFFFF00, 0xFF00FF, 0x00FFFF]
pins = {'pin_R':11, 'pin_G':12, 'pin_B':13}  

GPIO.setmode(GPIO.BOARD)
for i in pins:
	GPIO.setup(pins[i], GPIO.OUT)
	GPIO.output(pins[i], GPIO.HIGH)

p_R = GPIO.PWM(pins['pin_R'], 2000)  # set Frequece to 2KHz
p_G = GPIO.PWM(pins['pin_G'], 2000)
p_B = GPIO.PWM(pins['pin_B'], 5000)

p_R.start(0)      # Initial duty Cycle = 0(leds off)
p_G.start(0)
p_B.start(0)

def map(x, in_min, in_max, out_min, out_max):
	return (x - in_min) * (out_max - out_min) / (in_max - in_min) + out_min

def setColor(col):   # For example : col = 0x112233
	R_val = (col & 0xFF0000) >> 16
	G_val = (col & 0x00FF00) >> 8
	B_val = (col & 0x0000FF) >> 0
	
	R_val = map(R_val, 0, 255, 0, 100)
	G_val = map(G_val, 0, 255, 0, 100)
	B_val = map(B_val, 0, 255, 0, 100)
	
	p_R.ChangeDutyCycle(R_val)
	p_G.ChangeDutyCycle(G_val)
	p_B.ChangeDutyCycle(B_val)

try:
	while True:
		for col in colors:
			setColor(col)
			time.sleep(0.5)
except KeyboardInterrupt:
	p_R.stop()
	p_G.stop()
	p_B.stop()
	for i in pins:
		GPIO.output(pins[i], GPIO.HIGH)
	GPIO.cleanup()

                    `.trim()}
                    />

                </Section>
            </div>
        );
    }
}

export default withStyles(s)(RgbLED);
