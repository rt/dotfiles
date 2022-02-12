import { models } from 'kabuda-liquid';

// impl-start (imports) -using-default
// impl-end

export default class Item extends models.Model {
    constructor(o) {
        super(o);
        o = o || {};

        /** @type {uuid} */
        this.accountId = o.accountId;

        /** @type {string} */
        this.firstName = o.firstName || '';

        /** @type {string} */
        this.lastName = o.lastName || '';

        /** @type {string} */
        this.contactEmail = o.contactEmail || '';

        /** @type {string} */
        this.contactPhone = o.contactPhone || '';
    }

    // impl-start (functions) -using-default
    // impl-end
}

// impl-start (privateFunctions) -using-default
// impl-end
