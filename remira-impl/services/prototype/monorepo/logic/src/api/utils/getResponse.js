import jwt from 'jsonwebtoken';
import config from '../../config';

const getResponse = function (req, res) {
    //right now because routes need fetch (depends on Promise > multiple implementations) global cookies is easier
    const getReturnObject = function () {
        return {
            meta: {
                //csrfToken: req.csrfToken()
            },
        };
    };

    return {
        setJwtToken: function () {
            //const expiresIn = 60 * 60 * 24 * 180; // 180 days
            const expiresIn = 60; // 180 days
            const token = jwt.sign(req.user, config.auth.jwt.secret, {
                expiresIn,
            });
            res.cookie('id_token', token, {
                maxAge: 1000 * expiresIn,
                httpOnly: true,
            });
            return this;
        },

        sendError: function (error) {
            const retObj = getReturnObject();
            retObj.meta.error = error;
            //should this be 200?
            return res.status(500).json(retObj);
        },

        sendSuccess: function (data) {
            const retObj = getReturnObject();
            retObj.data = data;
            return res.status(200).json(retObj);
        },
    };
};

export default getResponse;
