import { expect } from 'chai';
import uuid from 'uuid';
import Data from './item';

import Item from '../../models/item';
import db from './index';

describe('#item', () => {
    beforeEach(() => {});

    afterEach(async () => {
        db.query('DELETE FROM item;', []);
    });

    describe('createItem', () => {
        it('should create data', async () => {
            const obj = new Item({
                firstName: 'firstName',
                lastName: 'lastName',
                contactEmail: 'contactEmail',
                contactPhone: 'contactPhone',
            });
            const dataObj = await Data.createItem(obj);
            expect(dataObj).to.be.instanceof(Item);
        });
    });

    describe('#deleteItem', () => {
        it('should delete data', async () => {
            const obj = new Item({
                firstName: 'firstName',
                lastName: 'lastName',
                contactEmail: 'contactEmail',
                contactPhone: 'contactPhone',
            });
            const dataObj = await Data.createItem(obj);
            await Data.deleteItem(dataObj.accountId);
        });
    });

    describe('#getItemList', () => {
        it('should retrieve all objects', async () => {
            const obj1 = new Item({
                firstName: 'firstName',
                lastName: 'lastName',
                contactEmail: 'contactEmail',
                contactPhone: 'contactPhone',
            });
            await Data.createItem(obj1);

            const obj2 = new Item({
                firstName: 'firstName',
                lastName: 'lastName',
                contactEmail: 'contactEmail',
                contactPhone: 'contactPhone',
            });
            await Data.createItem(obj2);

            const objects = await Data.getItemList();
            expect(objects).to.be.instanceof(Array);
            expect(objects.length).to.eq(2);
            expect(objects[0]).to.be.instanceof(Item);
            expect(objects[1]).to.be.instanceof(Item);
        });
    });
});
