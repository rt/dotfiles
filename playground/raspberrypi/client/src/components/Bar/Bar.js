import React from 'react';
import Base from '../../../Base';
import PropTypes from 'prop-types';
import withStyles from 'isomorphic-style-loader/lib/withStyles';
import s from './Bar.css';
import cx from 'classnames';
import Link from '../../../Link';
import logoUrl from './logo-small.png';
import { version }  from '../../../../../package.json';

class Bar extends Base {

    constructor(props) {
        super(props);
    }

    render() {

        let cls = null;
        cls = cx(s.root, s.container, this.props.className);
        return (
            <div data-e2e={this.e2e()} className={cx(cls)}>
                <Link className={s.brand} to="/">
                    <img data-e2e="logoImg" src={logoUrl} alt={this.uiData.translations.brand.text}/>
                    <span data-e2e="brandText" >{this.uiData.translations.brand.text}</span>
                    <span className={s.versionTxt}> v{version}</span>
                </Link>
            </div>
        );
    }
}

Bar.propTypes = {
    className: PropTypes.string,
};

export default withStyles(s)(Bar);
