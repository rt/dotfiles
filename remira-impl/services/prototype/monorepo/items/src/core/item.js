import { apiEnvelope } from './internal/utils';

// impl-start (imports) -using-default
// impl-end

export default {
    /**
     * @api
     * @return {Promise}
     */
    createItem: function (item) {
        return apiEnvelope(async () => {
            // impl-start (createItem) -using-default
            // impl-end
        });
    },

    /**
     * @api
     * @return {Promise}
     */
    getItem: function (itemId) {
        return apiEnvelope(async () => {
            // impl-start (getItem) -using-default
            // impl-end
        });
    },

    /**
     * @api
     * @return {Promise}
     */
    getItems: function () {
        return apiEnvelope(async () => {
            // impl-start (getItems)
            return [{ id: 1, name: 'hello' }];
            // process.argv.SA_LOGIC_API_URL
            // return axios.get(process.argv.SA_LOGIC_API_URL + '/users');
            // impl-end
        });
    },

    /**
     * @api
     * @return {Promise}
     */
    updateItem: function (itemId, item) {
        return apiEnvelope(async () => {
            // impl-start (updateItem) -using-default
            // impl-end
        });
    },

    /**
     * @api
     * @return {Promise}
     */
    deleteItem: function (itemId) {
        return apiEnvelope(async () => {
            // impl-start (deleteItem) -using-default
            // impl-end
        });
    },
};

// impl-start (privateMethods) -using-default
// impl-end
