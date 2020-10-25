import React from 'react';
import PropTypes from 'prop-types';
import withStyles from 'isomorphic-style-loader/lib/withStyles';
import s from './TakingYourRpiHome.css';
import Base from '../../../../Base';
import Section from '../../Section';
import Image from '../../../../Image';
import Code from '../../../../Code';

class TakingYourRpiHome extends Base {
    
    constructor(props) {
        super(props);
    }

    render() {

        return (
            <div data-e2e={this.e2e()}>

                <Section title="Support">

            The raspberry pi was used for learning in the classroom only.  
            We do not provide support after the class is over.
            That being said, if you folllow the directions below you <i>should</i> work.

                </Section>

                <Section title="Connecting">

                <p>
            
                    In the classroom the raspberry pi's are already set up to
            used the local network.  When you go home, they will not connect
            unless you set them up to.  You also don't have to connect them to
            your home network because you can connect directly with a USB
            cable.

            </p>

                    
            <h3>Mac or Linux</h3>

            If you have a Mac you can simply connect with <code>ssh</code> just as you did in the class room.

            <h3>Windows</h3>

            If you have Windows you will need to use an <i>ssh client</i> such
            as <i>putty</i>.  In addition, you need to install something that
            implements <i>zeroconf</i> such as <i>Bonjour Print Services</i>.
            <i>zeroconf</i> allows computer names to be resolved with the
            <i>.local</i> name.  Once those are installed you can connect to
            your raspberry pi with <i>putty</i> setting the hostname to what
            you used in the classroom, <i>your-name.local</i>.  You will be
            prompted for the username and password (use the same ones you used
                in class).

            <h3>iPad and Android Tablets</h3>

            It is only possible to use your iPad to connect if you attach it to
            your network first as described above.  Once attached to your network 
            you can use an <i>ssh</i> app such as <i>Termnus</i>.
            

                </Section>


            </div>
        );
    }
}

export default withStyles(s)(TakingYourRpiHome);
