import React from 'react';
import PropTypes from 'prop-types';
import withStyles from 'isomorphic-style-loader/lib/withStyles';
import s from './BasicCircuit.css';
import Base from '../../../../Base';
import Section from '../../Section';
import ConceptIntro from '../../ConceptIntro';
import Image from '../../../../Image';
import Code from '../../../../Code';

class BasicCircuit extends Base {
    
    constructor(props) {
        super(props);
    }

    render() {

        return (
            <div data-e2e={this.e2e()}>

                <Section title="Components">

                    <p>

                    </p>

                    <ConceptIntro title="Push Button" responsive="height" image="/push_button.png">
                        
                        <p>

            Buttons are a common component used to turn something on and off.  This button has four 
            legs which connect two pairs together when pushed.  It connects the legs on the longer side 
            of the button.  When placed over the gutter on the breadboard, this will connect two sides 
            together.


                        </p>
                        
                    </ConceptIntro>

                </Section>


                <Section title="Basic Circuit">

                    <p> 
            
            An electrical circuit is a path through which
            an electrical current flows. The path may be <i>closed</i> which makes makes electrical
            current flow possible or <i>open</i> where there is a break in the path and the current cannot flow.  
            
                    </p>

            <h3>High / Low states</h3>

                    <p>

            Each GPIO pin has two states, <i>HIGH</i> and <i>LOW</i>.  They can
            either read (<i>INPUT</i>) or write (<i>OUTPUT</i>) these two
            states.  When a pin is set to <i>OUTPUT</i> it can either send out 3.3V (HIGH), or 0V (LOW).
            If a pin is set to <i>INPUT</i> then the circuit must be closed for it to read either HIGH or low
            depending on whether you are connecting to 3.3V or 0V (ground).


                    </p>

                    <p>

            We could add the button to the LED circuit directly.  However, sometimes there is <i>interference</i>
            which will cause the LED to light up even when the button is off.  We can avoid this by
            using a <i>pull-down resistor</i> between the button and <i>ground</i> to consume the interference
            when the button is off.  We can detect when the button is on/off and then run the code to 
            turn the LED on/off.
                    
                    
                    </p>

                    <Image responsive="width" src="/basic_circuit_bb.png" alt="Picture of a Blinking LED Breadboard" />

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
    #GPIO.setup(6, GPIO.IN)
    GPIO.add_event_detect(6, GPIO.BOTH, callback=my_callback)
 
    message = raw_input('\nPress any key to exit.\n')
 
finally:
    GPIO.cleanup()
 
print("Goodbye!")

                    `.trim()}
                    />

                </Section>
            
            </div>
        );
    }
}

export default withStyles(s)(BasicCircuit);
