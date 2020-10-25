import React from 'react';
import PropTypes from 'prop-types';
import withStyles from 'isomorphic-style-loader/lib/withStyles';
import s from './BlinkingLED.css';
import Base from '../../../../Base';
import Section from '../../Section';
import ConceptIntro from '../../ConceptIntro';
import Image from '../../../../Image';
import Code from '../../../../Code';

class BlinkingLED extends Base {
    
    constructor(props) {
        super(props);
    }

    render() {

        return (
            <div data-e2e={this.e2e()}>
                <Section title="Components">

                    <ConceptIntro title="Through Hole LED" responsive="height" image="/led.png">
                        
                        <p>

                        A Light Emitting Diode (LED) emits light when a voltage
            is applied.  The longer leg (Anode) should be connected to the
            positive side and the shorter leg (Cathode) to the negative side.
            Generally if 2 - 3V (Voltage) is supplied with 5 - 30mA (Amperes)
            they will light up.  

                        </p>
                        
                    </ConceptIntro>

                    <ConceptIntro title="Resistor" responsive="width" image="/resistor_220.png">
                        
                        <p>

                        A resistor is used to reduce current or adjust a
            voltage level.  They have bands that tell the amount of resistence.
            This is called the <i>color code</i>.  You read the code
            left-to-right with the left side being the side with the band
            nearest to the connecting lead.  The colors will represent a digit
            or a multiplier.  4 and 5 band resistors are common (5 bands give
                more accuracy).  With these the first 3 or 4 bands give the
            basic value.  The last band is used to determine the tolerance of
            the resistor, the variation or error you may have with the
            resistor.

                        </p>

            <table>
                <thead>
                    <tr>
                        <td>Color</td><td>1st Digit</td><td>2nd Digit</td><td>3rd Digit</td><td>Multiplier</td> <td>Tolerance</td>
                    </tr>
                </thead>
                <tbody>
                    <tr className={s.black}>
                        <td>Black</td><td>0</td><td>0</td><td>0</td> <td>1Ω</td> <td></td>
                    </tr>
                    <tr className={s.brown}>
                        <td>Brown</td><td>1</td><td>1</td><td>1</td> <td>10Ω</td> <td>± 1%</td>
                    </tr>
                    <tr className={s.red}>
                        <td>Red</td> <td>2</td><td>2</td><td>2</td> <td>100Ω</td> <td>± 2%</td>
                    </tr>
                    <tr className={s.orange}>
                        <td>Orange</td> <td>3</td><td>3</td><td>3</td> <td>1KΩ</td> <td></td>
                    </tr>
                    <tr className={s.yellow}>
                        <td>Yellow</td> <td>4</td><td>4</td><td>4</td> <td>10KΩ</td> <td></td>
                    </tr>
                    <tr className={s.green}>
                        <td>Green</td> <td>5</td><td>5</td><td>5</td> <td>100KΩ</td> <td>± 0.5%</td>
                    </tr>
                    <tr className={s.blue}>
                        <td>Blue</td> <td>6</td><td>6</td><td>6</td> <td>1MΩ</td> <td>± 0.25%</td>
                    </tr>
                    <tr className={s.violet}>
                        <td>Violet</td> <td>7</td><td>7</td><td>7</td> <td>10MΩ</td> <td>± 0.1%</td>
                    </tr>
                    <tr className={s.grey}>
                        <td>Grey</td> <td>8</td><td>8</td><td>8</td> <td></td> <td>± 0.05%</td>
                    </tr>
                    <tr className={s.white}>
                        <td>White</td> <td>9</td><td>9</td><td>9</td> <td></td> <td></td>
                    </tr>
                    <tr className={s.gold}>
                        <td>Gold</td> <td></td><td></td><td></td> <td>0.1</td> <td>± 5%</td>
                    </tr>
                    <tr className={s.silver}>
                        <td>Silver</td> <td></td><td></td><td></td> <td>0.01</td> <td>± 10%</td>
                    </tr>
                </tbody>
            </table>
                        
                    </ConceptIntro>

                </Section>


                <Section title="Build the circuit">

                    <p>
                    
                    The current from the Raspberry Pi is more current (50 - 250mA) than we need (30mA),
                    so we will use a resistor to limit the current.

                    <i>Ohm's Law: V = I × R</i>

                    The desired current for the LED is 25mA and the Vf of an LED is about 1.8V. 
                    3.3V (power source) - 1.8V (LED voltage drop) = 1.2V (Use this to calculate our resistor value).
                    1.2 V = 25 mA × R, or 1.2/25 mA = R.  1.2 V / 0.025 A = 48 Ω

                    
                    </p>

                    <Image responsive="width" src="/blinking_led_bb.png" alt="Picture of a Blinking LED Breadboard" />

                </Section>




                <Section title="Write the code">

                    <Code
                        text={`
#!/usr/bin/env python

import RPi.GPIO as GPIO
import time

LedPin = 11

def setup():
    GPIO.setmode(GPIO.BOARD)
    GPIO.setup(LedPin, GPIO.OUT)
    GPIO.output(LedPin, GPIO.HIGH)

def loop():
    while True:
        print 'ON'
        GPIO.output(LedPin, GPIO.LOW)
        time.sleep(0.5)

        print 'OFF'
        GPIO.output(LedPin, GPIO.HIGH)
        time.sleep(0.5)

def destroy():
    GPIO.output(LedPin, GPIO.HIGH)
    GPIO.cleanup()

if __name__ == '__main__':
    setup()
    try:
        loop()
    except KeyboardInterrupt:  # on ctrl-c
        destroy()

                    `.trim()}
                    />

                </Section>




                <Section title="Other things to try">
                    <ul>
                        <li>Change the delay time.</li>
                        <li>Try to make it work by using <i>GND</i> not <i>3.3V</i></li>
                        <li>Change the resistor to see the brightness change.</li>
                    </ul>
                </Section>
            </div>
        );
    }
}

export default withStyles(s)(BlinkingLED);
