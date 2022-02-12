import chai from 'chai';
import sinonChai from 'sinon-chai';
import chaiAsPromised from 'chai-as-promised';

process.env.NODE_ENV = 'test';
process.env.SKELETON_DB_NAME = 'unit';

// For components
// Disable webpack-specific features for tests since
// Mocha doesn't know what to do with them.
['.css', '.scss', '.md', '.png', '.jpg', '.jpeg', '.gif', '.svg'].forEach(
    (ext) => {
        require.extensions[ext] = () => null;
    }
);

before(function () {
    chai.use(sinonChai);
    chai.use(chaiAsPromised);
    chai.should();

    // ##datastores##
});

beforeEach(function () {});

afterEach(function () {
    //this.sandbox.restore();
});
