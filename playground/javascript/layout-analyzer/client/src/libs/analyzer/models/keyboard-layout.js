import { models } from 'kabuda';


export default class KeyboardLayout extends models.Model {
    constructor(o) {
        super(o);

        this.layers = this.layers || [];
    }

    /**
     * Generate effort maps for each key
     */
    generateMaps(config) {

    }

    /**
     * Generate the default map when prevKey, etc not concerned
     */
    generateDefaultMap(config) {
    }

    run(text) {
        let prevKey = null;
        let lastOppositeHandKey = null; //last hand is not necessarally last char

        //for chars
        //
        //find currentKey
        //
        //prevKey.getEffort(currentKey, defaultMap);
    }
}
