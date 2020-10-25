import React from 'react';
import PropTypes from 'prop-types';
import withStyles from 'isomorphic-style-loader/lib/withStyles';
import s from './Environment.css';
import Base from '../../../../Base';
import Code from '../../../../Code';
import Image from '../../../../Image';
import Section from '../../Section';
import Hr from '../../../../Hr';
import GpioPins from '../GpioPins';

class Environment extends Base {
    
    constructor(props) {
        super(props);
    }

    render() {

        return (
            <div data-e2e={this.e2e()}>
                <Section title="Raspberry Pi">

                    <p>

                The Raspberry Pi is a tiny computer that often used for learning
                programming.  The operating system is Linux (Debian) based
                optimized for the Raspberry Pi called Raspbian.  Raspbian comes
                pre-installed with software for education and programming.  Because
                it is Linux based it similar to what runs most servers on the
                Internet, as well as consumer devices such as Macs, iPad/iPros,
                Android, Chromebooks, and much more.  This operating system is on the MicroSD card.
                    
                    </p>

                    <div className={s.breadboardContainer}>
                        <div>
                            <b>Raspberry Pi 3 Model B</b>
                            <Image responsive="width" src="/rpi3.png" alt="Picture of a Raspberry Pi 3" />
                        </div>
                        <div>
                            <b>Raspberry Pi Zero</b>
                            <Image responsive="width" src="/rpizero.png" alt="Picture of a Raspberry Pi Zero" />
                        </div>
                    </div>

                </Section>

                <Section title="GPIO">

                    <p>

            GPIO (General Purpose input/output) pins help interact with the
            real world.  The pins can either take <i>input</i> or
            <i>output</i>.

                    </p>
                    <GpioPins />

                </Section>

                <Section title="Breadboard">
                    <p>

                Breadboards are a fundamental part of learning how to build electronic circuits.
                They allow you to create circuits without soldering.  The breadboard has 
                a grid of tie-points (holes) that are connect inside with metal strips.  This 
                is what allows you to connect circuits without soldering.  The way in which they are 
                connected allows you to prototype circuits with some structure.

                    </p>

                    <div className={s.breadboardContainer}>
                        <Image responsive="width" src="/breadboard.png" alt="Picture of a breadboard" />

                        <div>
                            <h3>Power Bus</h3>
                            The red columns are usually connected to power the breadboard.  Once given power, it is easy to draw
                            power from any of the tie-points.

                            <h3>Ground Bus</h3>
                            The blue columns ...



                            <h3>Tie-Points Rows</h3>
                            <p>
                                The rows highlighted in green show
                            </p>
                        </div>
                    </div>
                </Section>


             <Section title="Client/Server">
                    <p>


            On each Raspberry Pi there is a <i>server</i> running.  ...

                        <ul>
                            <li>Open a terminal...</li>
                        </ul>

                    </p>


                    <h3>Secure Shell (ssh)</h3>
                    <p>

                Because we often already have a computer or tablet, we can use those to remotely access
                the Raspberry Pi.  This way we don't need to purchase another monitor for the raspberry pi.
                We do this buy using a program called <code>ssh</code>.  Let's try this now.
                        
                        <Code
                            text={`
        $ ssh pi@yourpi.local
                            `.trim()}
                        />

                    </p>
                </Section>   


            </div>
        );
    }
}

export default withStyles(s)(Environment);
