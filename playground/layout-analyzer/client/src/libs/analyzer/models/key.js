import { models } from 'kabuda';

export default class Key extends models.Model {
    constructor(o) {
        super(o);

        this.char = this.char || '';
        this.width = this.width || 1;
        this.finger = this.finger || 0;
    }
}
