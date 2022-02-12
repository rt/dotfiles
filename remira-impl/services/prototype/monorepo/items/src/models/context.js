import { models } from 'kabuda-liquid';

// impl-start (imports) -using-default
// impl-end

export default class Context extends models.Model {
    constructor(o) {
        super(o);
        o = o || {};

        /** @type {uuid} */
        this.userId = o.userId;

        /** @type {uuid} */
        this.accountId = o.accountId;

        /** @type {Array.<string>} */
        this.roles = o.roles || [];
    }

    // impl-start (functions) -using-default
    // impl-end
}

// impl-start (privateFunctions) -using-default
// impl-end
