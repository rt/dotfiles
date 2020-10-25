import React from 'react';
import PropTypes from 'prop-types';
import withStyles from 'isomorphic-style-loader/lib/withStyles';
import s from './AboutRpi.css';
import Base from '../../../../Base';
import Section from '../../Section';
import NavList from '../../../../NavList';

class AboutRpi extends Base {
    
    constructor(props) {
        super(props);
    }

    render() {

        return (
            <div data-e2e={this.e2e()}>
                <Section title="Purpose">

                <p>
                    
            The purpose of this course is to give students a hands-on
            experience with serveral technologies from hardware and electric
            circuits to client/server communication.  They will learn about
            circuits and various components as well as write software to
            control them.  They will learn how to navigate a file system and make programs
            with a native Linux text editor (no drag-and-drop block coding).

                </p>

            <p>

Learn how hardware and software work at the nuts and bolts level.  Program apps
with real code and learn how they work in both standalone and client/server
situations.

What we'll do
            <ul>
                <li>
                - Learn the basics of a Linux system and how to edit text files (programs)
                </li>
                <li>
                - Learn how basic circuitry works and make programs that control them
                </li>
                <li>
                - Look at programs in two languages (Python and Javascript)
                </li>
                <li>
                - Create programs that interact with servers
                </li>
            </ul>
- Do this in a fun and interactive environment.

            </p>

            Other Possibilities
                <ul>
                    <li>Dot Matrix</li>
                    <li>Buzzer and Transistors</li>
                </ul>

                </Section>

                <nav>
                    <NavList 
                        array={this.getChildRoutes()} 
                    />
                </nav>
            </div>
        );
    }
}

export default withStyles(s)(AboutRpi);
