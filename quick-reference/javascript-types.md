import chai from 'chai';

chai.expect();

const expect = chai.expect;

describe('Data Types', () => {

    beforeEach(() => {

    });

    describe('declaration and basic types', () => {
        it('let when you want to assign later', () => {

            let a = 1;
            a = 2;
            expect(a).to.eq(2);

            console.log(a.toPrecision(2));


        });
    });
    
    describe('const, use whenever you can', () => {
        it('cannot be assigned twice but the reference internals can be changed', () => {

            const b = 1;
            //cannot assign again
            //b = 2; 
            //expect to throw error

            const o = {};
            o.a = 1;
            expect(o.a).to.eq(1);

            const list = [];
            list.push(1);
            expect(list.length).to.eq(1);
        });
    });

    describe('native types, dont use the wrappers', () => {
        it('should not equal their wrapper', () => {

            let num = 1;
            expect(num).to.not.be.instanceof(Number);
            //but why is it that you can use all the Number.prototype functions?  must internally convert?

            let numWrapper = new Number(1);
            expect(num).to.not.eq(numWrapper);

            let str = 'hello';
            expect(str).to.not.be.instanceof(String);

            let strWrapper = new String('hello');
            expect(str).to.not.eq(strWrapper);

            let bool = true;
            expect(bool).to.not.be.instanceof(Boolean);

            let boolWrapper = new Boolean(true);
            expect(bool).to.not.eq(boolWrapper);

        });
    });

    describe('falsy', () => {
        it('should make no sense other than to remember', () => {

            expect(undefined).to.be.falsy;
            expect(null).to.be.falsy;
            expect('').to.be.falsy;
            expect(0).to.be.falsy;
            expect(NaN).to.be.falsy;

            expect(!undefined).to.be.true;
            expect(!null).to.be.true;
            expect(!NaN).to.be.true;
            expect(!0).to.be.true;
            expect(!('')).to.be.true;

            
            expect(undefined === undefined).to.be.true;
            
            expect(null === null).to.be.true;

            //interesting
            expect(NaN === NaN).to.be.false;
            
            expect(0 === 0).to.be.true;

            expect('' === '').to.be.true;
        });
    });

    describe('identity(===) vs equality(==)', () => {
        it('compare can be tricky with conversion when not the same type, always use identity', () => {

            expect(undefined == null).to.be.true; //as expected except for this
            expect(undefined === null).to.be.false;

            expect('12' == 12).to.be.true; 
            expect('12' === 12).to.be.false; 


        });
    });
    
});

