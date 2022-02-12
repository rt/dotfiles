import uuid from 'uuid';
import Item from '../../models/item';
import Base from './base';
import db from './index';

/**
 */
export default class ItemData extends Base {
    /**
     * @param {Item} item
     * return {Item | null}
     */
    static async createItem(item) {
        item.accountId = uuid.v1();
        await db.query(
            `
INSERT INTO item(account_id, first_name, last_name, contact_email, contact_phone)
VALUES ($1, $2, $3, $4, $5);
        `.trim(),
            [
                item.accountId,
                item.firstName,
                item.lastName,
                item.contactEmail,
                item.contactPhone,
            ]
        );
        return this.getItem(item.accountId);
    }

    /**
     * @param {string} accountId
     */
    static async deleteItem(accountId) {
        return db.query(
            `
DELETE FROM item WHERE account_id = $1;
        `.trim(),
            [accountId]
        );
    }

    /**
     * @param {string} accountId
     * return {Item | null}
     */
    static async getItem(accountId) {
        return db
            .query(
                `
SELECT item.account_id, item.first_name, item.last_name, item.contact_email, item.contact_phone FROM item
    
            WHERE item.account_id = ($1)
            ;
        `.trim(),
                [accountId]
            )
            .then((res) => {
                if (res.rows.length === 0) {
                    return null;
                }

                return new Item(res.rows[0]);
            });
    }

    /**
     * @return {Array.<Item>}
     */
    static async getItemList() {
        return db
            .query(
                `
SELECT * FROM item;
        `.trim(),
                []
            )
            .then((res) => {
                return res.rows.map((obj) => {
                    return new Item(obj);
                });
            });
    }

    /**
     * @param {string} accountId
     * @param {Item} account
     */
    static async updateItem(accountId, item) {
        return db
            .query(
                `
UPDATE item SET first_name = ($2), last_name = ($3), contact_email = ($4), contact_phone = ($5) WHERE account_id = ($1);
        `.trim(),
                [
                    item.accountId,
                    item.firstName,
                    item.lastName,
                    item.contactEmail,
                    item.contactPhone,
                ]
            )
            .then(() => {
                return ItemData.getItem(accountId);
            });
    }
}
