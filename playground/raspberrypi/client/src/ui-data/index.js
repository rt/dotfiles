import home_en from './apps/home/en';
import home_ja from './apps/home/ja';
import reference_en from './apps/reference/en';
import reference_ja from './apps/reference/ja';
import yoteam_en from './apps/yoteam/en';
import yoteam_ja from './apps/yoteam/ja';
import learn_en from './apps/learn/en';
import learn_ja from './apps/learn/ja';
import deepmerge from 'deepmerge';

export default {
    apps: {
        home: {
            en: home_en,
            ja: deepmerge(home_en, home_ja)
        },
        reference: {
            en: reference_en,
            ja: deepmerge(reference_en, reference_ja)
        },
        yoteam: {
            en: yoteam_en,
            ja: deepmerge(yoteam_en, yoteam_ja)
        },
        learn: {
            en: learn_en,
            ja: deepmerge(learn_en, learn_ja)
        }
    }
};

