import React from 'react';
import PropTypes from 'prop-types';
import withStyles from 'isomorphic-style-loader/lib/withStyles';
import s from './JanKenPo.css';
import Base from '../../../../Base';
import Section from '../../Section';
import Image from '../../../../Image';
import Code from '../../../../Code';

class JanKenPo extends Base {
    
    constructor(props) {
        super(props);
    }

    render() {

        return (
            <div data-e2e={this.e2e()}>
                <Section title="App Logic">

                <p>
                    

                </p>

                </Section>


            </div>
        );
    }
}

export default withStyles(s)(JanKenPo);
