/* eslint-disable no-console */
// import RoleManager from '../core/role-manager';
import getResponse from './utils/getResponse';
import item from '../core/item';

export default function (app) {
    app.post('/item/v1', async (req, res) => {
        const params = {
            context: req.session.context,
            item: req.body,
        };

        item.createItem(params.item)
            .then((ret) => {
                return getResponse(req, res).sendSuccess(ret);
            })
            .catch((e) => {
                return getResponse(req, res).sendError({
                    success: false,
                    data: e,
                });
            });
    });

    app.get('/item/v1', async (req, res) => {
        const params = {
            context: req.session.context,
        };

        item.getItems()
            .then((ret) => {
                return getResponse(req, res).sendSuccess(ret);
            })
            .catch((e) => {
                return getResponse(req, res).sendError({
                    success: false,
                    data: e,
                });
            });
    });

    app.get('/item/v1/:item_id', async (req, res) => {
        const params = {
            context: req.session.context,

            itemId: req.params.item_id,
        };

        item.getItem(params.itemId)
            .then((ret) => {
                return getResponse(req, res).sendSuccess(ret);
            })
            .catch((e) => {
                return getResponse(req, res).sendError({
                    success: false,
                    data: e,
                });
            });
    });

    app.put('/item/v1/:item_id', async (req, res) => {
        const params = {
            context: req.session.context,
            item: req.body,
            itemId: req.params.item_id,
        };

        item.updateItem(params.itemId, params.item)
            .then((ret) => {
                return getResponse(req, res).sendSuccess(ret);
            })
            .catch((e) => {
                return getResponse(req, res).sendError({
                    success: false,
                    data: e,
                });
            });
    });

    app.delete('/item/v1/:item_id', async (req, res) => {
        const params = {
            context: req.session.context,

            itemId: req.params.item_id,
        };

        item.deleteItem(params.itemId)
            .then((ret) => {
                return getResponse(req, res).sendSuccess(ret);
            })
            .catch((e) => {
                return getResponse(req, res).sendError({
                    success: false,
                    data: e,
                });
            });
    });
}
