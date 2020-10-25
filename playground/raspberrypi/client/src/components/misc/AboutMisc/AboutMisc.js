import React from 'react';
import PropTypes from 'prop-types';
import withStyles from 'isomorphic-style-loader/lib/withStyles';
import cx from 'classnames';
import s from './AboutMisc.css';
import Base from '../../../../Base';
import Hr from '../../../../Hr';
import NavList from '../../../../NavList';

class AboutMisc extends Base {
    
    constructor(props) {
        super(props);
    }

    render() {

        return (
            <div data-e2e={this.e2e()}>
                <p>
                    
            Misc contains basic introductions to technologies so that students
            can start using them in their courses.  

                </p>

                <nav>
                    <NavList 
                        array={this.getChildRoutes()} 
                    />
                </nav>
            </div>
        );
    }
}

export default withStyles(s)(AboutMisc);
