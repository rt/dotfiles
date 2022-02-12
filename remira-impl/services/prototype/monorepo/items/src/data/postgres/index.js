import pg from 'pg';
import pgCamelCase from 'pg-camelcase';

const revertCamelCase = pgCamelCase.inject(pg);

const pool = new pg.Pool();

export default {
    query: async (text, params) => {
        return pool.query(text, params);
    },
};
