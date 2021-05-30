
//In a ficticious application you need to check whether a string contains "SOME_CODE".  Add a function to the native String prototype that returns whether this condition is true/false.
//Do you think it is ok to add to native type's prototype chain?  Why, or why not.

// What does the folloing log to the console?
function test() {
   console.log(a);
   console.log(foo());
   
   var a = 1;
   function foo() {
      return 2;
   }
}

test();


// What does the folloing log to the console?
var fullname = 'John Doe';
var obj = {
   fullname: 'Colin Ihrig',
   prop: {
      fullname: 'Aurelio De Rosa',
      getFullname: function() {
         return this.fullname;
      }
   }
};

console.log(obj.prop.getFullname());

var test = obj.prop.getFullname;

console.log(test());

