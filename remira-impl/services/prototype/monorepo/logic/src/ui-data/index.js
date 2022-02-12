import deepmerge from 'deepmerge';
import en from './en';
import jp from './jp';

export default {
    en: en,
    jp: deepmerge(en, jp),
};
