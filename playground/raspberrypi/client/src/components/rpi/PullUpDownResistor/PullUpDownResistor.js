import React from 'react';
import PropTypes from 'prop-types';
import withStyles from 'isomorphic-style-loader/lib/withStyles';
import s from './PullUpDownResistor.css';
import Base from '../../../../Base';
import Section from '../../Section';
import ConceptIntro from '../../ConceptIntro';
import Image from '../../../../Image';
import Code from '../../../../Code';

class PullUpDownResistor extends Base {
    
    constructor(props) {
        super(props);
    }

    render() {

        return (
            <div data-e2e={this.e2e()}>

                <Section title="Components">

                    <p>

            When a circuit is open a GPIO pin might not be in the state you think it is due
            to random radiation or electromagnetic signals from the environment.  When in
            an open state we need a way to force the pin to <i>LOW</i> or <i>HIGH</i>.  This 
            is call <i>pull down</i> or <i>pull down</i> depending on whether the original circuit is
            connected to a voltage source (3.3V) or ground.

            When you have a circuit that connects 3.3V to a GPIO pin, it will read <i>HIGH</i> when the circuit is closed.
            When it is open, we need a <i>pull down</i> resistor connecting the circuit to ground, so that it reads <i>LOW</i>.
            When you have a circuit that connects to ground to a GPIO pin, it will real <i>LOW</i> when the circuit is closed.
            In this case, we will need a <i>pull up</i> resistor to that it reas <i>HIGH</i> in open state.

                    </p>

                </Section>


                <Section title="Example with interference">

                    <p>

                   Build the following circuit where a depressed button leaves the circuit in an <i>open</i> state.
            This is the same code you used in "Basic Circuit" with one line changed in the code.
                    
                    </p>

                    <Image responsive="width" src="/basic_circuit_bb.png" alt="Picture of a basic circuit." />

                </Section>

                <Section title="Write the code">

                    <Code
                        text={`

# coding=utf-8
 
import RPi.GPIO as GPIO
import datetime
 
def my_callback(channel):
    if GPIO.input(6) == GPIO.HIGH:
        print('\n▼  at ' + str(datetime.datetime.now()))
    else:
        print('\n ▲ at ' + str(datetime.datetime.now())) 
 
try:
    GPIO.setmode(GPIO.BCM)
    GPIO.setup(6, GPIO.IN)
    GPIO.add_event_detect(6, GPIO.BOTH, callback=my_callback)
 
    message = raw_input('\nPress any key to exit.\n')
 
finally:
    GPIO.cleanup()
 
print("Goodbye!")

                    `.trim()}
                    />

                </Section>
                
            
                <Section title="Basic circuit with pull down resistor">

                    <p>

                    
            If we a higher value resistor and connect it to ground it will go through this path when the original circuit is open.
            When the original circuit is closed it will go through that path because the resistence is less.
                    
                    </p>

                    <Image responsive="width" src="/basic_circuit_pull_down_resistor_bb.png" alt="Picture of a Blinking LED Breadboard" />

                </Section>

                <Section title="Use internal pull-down resistor">

                    <p>

            The Raspberry Pi has its own internal 1.8kΩ resistor that we can conveniently use.
            Replace the following line
            
                    </p>

                    <Code
                        text={`
    GPIO.setup(6, GPIO.IN)
                    `.trim()}
                    />

            with this
                    
                    <Code
                        text={`
    GPIO.setup(6, GPIO.IN, pull_up_down=GPIO.PUD_DOWN)
                    `.trim()}
                    />

                    <Image responsive="width" src="/basic_circuit_pull_down_resistor_bb.png" alt="Picture of a Blinking LED Breadboard" />

                </Section>
            </div>
        );
    }
}

export default withStyles(s)(PullUpDownResistor);
