# Funcitonal

Some functinoal thought without javascript.

Two big problems with OOP 
- The tight coupling of data and code.
- Ubiquitous use of side effects.

There is no *direction* for the dependencies (they can point anywhere)


When you think in terms of inputs and outputs, there are no function
dependencies, only data dependencies. That's what makes them so easy to unit
test. Your next layer up arranges for the output of one function to be fed into
the input of the next, and can easily swap out the various implementations as
needed.

Changing implementations is as easy as swapping functions with the same input
and output.  An *interface* provides something similar but more complex because
you can have multiple methods (> `@FunctionalInterface` in java)

https://softwareengineering.stackexchange.com/questions/275891/is-functional-programming-a-viable-alternative-to-dependency-injection-patterns


##

https://www.smashingmagazine.com/2014/07/dont-be-scared-of-functional-programming/

When programming in a functional style, you’re always looking for simple,
repeatable actions that can be abstracted out into a function (than will be composable). 

Simple Rules
- All of your functions must accept at least one argument.
- All of your functions must return data or another function.
- No loops!

### Immutable Data


### Stateless

### No *Side Effect*

Basically, this means some change in state, changing something somewhere.  Pure
functions makes it easier to reason about the correctness of the program.
import chai from 'chai';

chai.expect();

const expect = chai.expect;

/**
 * Functional Exercise
*/
describe.only('Test Driven Development', () => {

	/*
		imperative program might look like this
		var coords = [],
			totalTemperature = 0,
			averageTemperature = 0;

		for (var i=0; i < data.length; i++) {
			totalTemperature = 0;

			for (var j=0; j < data[i].temperatures.length; j++) {
				totalTemperature += data[i].temperatures[j];
			}

			averageTemperature = totalTemperature / data[i].temperatures.length;

			coords.push([averageTemperature, data[i].population]);
		}
	*/
	//input 
	var data = [
		{ 
			name: "Jamestown",
			population: 2047,
			temperatures: [-34, 67, 101, 87]
		},
		{
			name: "Awesome Town",
			population: 3568,
			temperatures: [-3, 4, 9, 12]
		},
		{
			name: "Funky Town",
				population: 1000000,
				temperatures: [75, 75, 75, 75, 75]
		}
	];
	//output
	//[
		//[x, y],
		//[x, y]
		//…etc
	//]
	
	//----- functions -----
	
	function addNumbers(a, b) {
		return a + b;
	}

	//no loops, use recursion (pass array and use first value)
	//function totalForArray(currentTotal, arr) {
		////currentTotal += arr[0];
		//currentTotal = addNumbers(currentTotal, arr[0]); //for the purist
		
		//// using Array.shift on purpose because we're treating arrays as if they are immutable.
		//var remainingList = arr.slice(1);

		//if (remainingList.length > 0) {
			//return totalForArray(currentTotal, remainingList);
		//} else {
			//return currentTotal;
		//}
	//}

	//reduce is cleaner
	function totalForArray(arr) {
		return arr.reduce(addNumbers);
	}

	function average(total, count) {
		return total/count;
	}

	function averageForArray(arr) {
		return average(totalForArray(arr), arr.length);
	}

	//data.map(function(item) { return item.temperatures }
	
	//we could use `map` w/annonymous function but getting a single property
	//from a collection is common, so make it a function that returns a
	//function (because that's what the other function expects)
	function getItem(propertyName) {
		// Return a function that retrieves that item, but don't execute the
		// function.  We'll leave that up to the method that is taking action
		// on items in our array.
	
		return function(item) { 
			return item[propertyName]; 
		} 
	}

	function pluck(arr, propertyName) {
		//return arr.map(item => item[propertyName]);
		return arr.map(getItem(propertyName));
	}

	function combineArrays(arr1, arr2, finalArr) {
		finalArr = finalArr || [];
		finalArr.push([arr1[0], arr2[0]]);

		var remaingArr1 = arr1.slice(1);
		var remaingArr2 = arr2.slice(1);

		if (remaingArr1.length === 0 && remaingArr2.length === 0) {
			return finalArr;
		} else {
			//recursion
			return combineArrays(remaingArr1, remaingArr2, finalArr);
		}
	}

    beforeEach(() => {
		//because everything is immutable, might not need to do anything in beforeEach

    });

    describe('compare the average temperature to population size', () => {

        it('totalForArray', () => {

            expect(totalForArray([4, 1, -2])).to.eq(3);

        });
		
		it('averageForArray', () => {

			expect(averageForArray([2, 4])).to.eq(3);
        });
		
		it('pluck', () => {

			expect(pluck([
				{prop: 2},
				{prop: 4}
			], 'prop')).to.deep.eq([2,4]);
        });
		
		it('combineArrays (full integration)', () => {

			var processed = combineArrays(pluck(data, 'temperatures').map(averageForArray), pluck(data, 'population'));

			expect(processed).to.deep.eq([
				[
					55.25, 2047
				],
				[
					5.5, 3568
				],
				[
					75, 1000000
				],
			]);
        });

    });
    
});

