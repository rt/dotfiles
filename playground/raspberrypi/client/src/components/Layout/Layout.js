import React from 'react';
import Base from '../../../Base';
import PropTypes from 'prop-types';
import withStyles from 'isomorphic-style-loader/lib/withStyles';
import cx from 'classnames';
import s from './Layout.css';
import Bar from '../Bar';
import Hr from '../../../Hr';
import NavList from '../../../NavList';
import ArticleContainer from '../../../ArticleContainer';
import FadeAndSlideTransition from '../../../transitions/FadeAndSlideTransition';
import LearnCard from '../LearnCard';
import Divider from '../../../Divider';
import { stores } from '../../../../libs/home';

const getStateStore = stores.stateStore.getStateStore;

class Layout extends Base {

    static contextTypes = {
        currentPath: PropTypes.string
    };

    constructor(props) {
        super(props);
        
    }

    componentDidMount = () => {
        //disable document scroll
        document.body.style.overflow = 'hidden';
    }

    getList = () => {
        return (
            <nav className={cx(s.tabList, s.animateOpacity)}>
                <NavList 
                    array={this.getRoutes()} 
                />
            </nav>
        );
    }

    render() {
        return (
            <div data-e2e={this.e2e()} className={s.root}>
                <div className={s.topBar}>
                    <Bar 
                        array={this.uiData.nav} 
                    />
                </div>
                <div className={s.container}>
                    <LearnCard 
                        currentPath={this.context.currentPath}
                        routes={getStateStore().getRouteHistoryManager().getBreadCrumbRoutes(this.context.currentPath, this.uiData.routes)}
                    />
                </div>
                <div className={cx(s.content)}>
                    <div className={cx(s.nav, s.container)}>
                        {this.getList()}
                    </div>
                    <div className={cx(s.article, s.container)}>
                        <ArticleContainer>
                            <div className={s.articleContents}>
                                <div className={s.articleHeader}>
                                </div>
                                <div className={s.articleBody}>
                                    {React.cloneElement(this.props.children, {appState: this.props.appState})}
                                </div>
                            </div>
                        </ArticleContainer>
                    </div>
                </div>
            </div>
        );
    }
}

Layout.propTypes = {
    children: PropTypes.node.isRequired,
};

export default withStyles(s)(Layout);
