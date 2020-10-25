import React from 'react';
import PropTypes from 'prop-types';
import withStyles from 'isomorphic-style-loader/lib/withStyles';
import s from './Learn.css';
import Base from '../../../Base';
import Hr from '../../../Hr';
import NavList from '../../../NavList';

class Learn extends Base {

    render() {

        return (
            <div data-e2e={this.e2e()}>
                <p>
                    <nav>
                        <NavList 
                            array={this.getChildRoutes()} 
                        />
                    </nav>
                </p>
            </div>
        );
    }
}

export default withStyles(s)(Learn);
