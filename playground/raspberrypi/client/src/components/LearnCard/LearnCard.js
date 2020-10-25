import React from 'react';
import Base from '../../../Base';
import PropTypes from 'prop-types';
import withStyles from 'isomorphic-style-loader/lib/withStyles';
import s from './LearnCard.css';
import cx from 'classnames';
import BreadCrumbs from '../../../BreadCrumbs';

class LearnCard extends Base {

    constructor(props) {
        super(props);
    }

    getRouteObject() {
        return this.uiData.routes.find((page) => {
            return page.route === this.props.currentPath;
        });
    }

    render() {

        return (
            <div data-e2e={this.e2e()} className={s.root}>
                <span className={s.breadCrumbs}>
                    <BreadCrumbs
                        routes={this.props.routes}
                    />
                </span>
                <div className={cx(s.titles)}>
                    <h3 className={cx(s.listHeader)}>Lessons</h3>
                    <h1 className={cx(s.name)}>
                        {this.getRouteObject() && this.getRouteObject().text}
                    </h1>
                </div>
            </div>
        );
    }
}

LearnCard.propTypes = {
    routes: PropTypes.array.isRequired,
};
export default withStyles(s)(LearnCard);
