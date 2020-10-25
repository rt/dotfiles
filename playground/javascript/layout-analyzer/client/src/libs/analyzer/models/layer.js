import { models } from 'kabuda';


export default class Layer extends models.Model {
    constructor(o) {
        super(o);

        this.mod = this.mod || null;
        this.modPenalty = this.modPenalty || 0;
        this.rows = this.rows || [];
    }
}
