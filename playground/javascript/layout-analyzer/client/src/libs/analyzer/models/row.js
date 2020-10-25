import { models } from 'kabuda';

export default class Row extends models.Model {
    constructor(o) {
        super(o);

        this.keys = this.keys || [];
    }
}
