import React from 'react';
import PropTypes from 'prop-types';
import withStyles from 'isomorphic-style-loader/lib/withStyles';
import s from './PythonReference.css';
import Base from '../../../../Base';
import BlockQuote from '../../../../BlockQuote';
import Code from '../../../../Code';
import Link from '../../../../Link';
import Section from '../../Section';

class PythonReference extends Base {
    
    constructor(props) {
        super(props);
    }

    render() {

        return (
            <div data-e2e={this.e2e()}>

                <Section title="Purpose">

                    <BlockQuote
                        text="Python is a programming language that lets you work quickly
and integrate systems more effectively. "
                        author="https://www.python.org/"
                    />

                    <p>
Python is often already installed in many Linux distributions.
                    </p>
                    <Code
                        text={`

python3 -V

                        `.trim()}
                    />

                </Section>


                <Section title="Pip">
                    <p>

            Package management is done with Pip (Python Package Index)

                    </p>

                    <Code
                        text={`

# python 3.x
sudo apt-get install -y python3-pip
...
pip3 install package_name

# dev env stuff
sudo apt-get install build-essential libssl-dev libffi-dev python-dev


                        `.trim()}
                    />

                </Section>


            </div>
        );
    }
}

export default withStyles(s)(PythonReference);
