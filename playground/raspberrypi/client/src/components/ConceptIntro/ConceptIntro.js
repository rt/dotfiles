import React from 'react';
import PropTypes from 'prop-types';
import withStyles from 'isomorphic-style-loader/lib/withStyles';
import cx from 'classnames';
import s from './ConceptIntro.css';
import Base from '../../../Base';
import Image from '../../../Image';

export class ConceptIntro extends Base {

    constructor(props) {
        super(props);
    }
    render() {
        return (
            <div data-e2e={this.e2e()} className={s.root}>
                <div className={cx(s.description, s.containerFull)}>
                        <span className={s.image}>
                            <Image responsive={this.props.responsive || "width"} src={this.props.image} />
                        </span>
                    <h3>{this.props.title}</h3>
                    {this.props.children}
                </div>
            </div>
        );
    }
};



export default withStyles(s)(ConceptIntro);
