https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object

**Instance properties**

Object.prototype.constructor
Specifies the function that creates an object's prototype.

Object.prototype.__proto__
Points to the object which was used as prototype when the object was instantiated.

**Instance methods**

Object.prototype.__defineGetter__()
Associates a function with a property that, when accessed, executes that function and returns its return value.

Object.prototype.__defineSetter__()
Associates a function with a property that, when set, executes that function which modifies the property.

Object.prototype.__lookupGetter__()
Returns the function associated with the specified property by the __defineGetter__() method.

Object.prototype.__lookupSetter__()
Returns the function associated with the specified property by the __defineSetter__() method.

Object.prototype.hasOwnProperty()
Returns a boolean indicating whether an object contains the specified property as a direct property of that object and not inherited through the prototype chain.

Object.prototype.isPrototypeOf()
Returns a boolean indicating whether the object this method is called upon is in the prototype chain of the specified object.

Object.prototype.propertyIsEnumerable()
Returns a boolean indicating if the internal ECMAScript [[Enumerable]] attribute is set.

Object.prototype.toLocaleString()
Calls toString().

Object.prototype.toString()
Returns a string representation of the object.

Object.prototype.valueOf()
Returns the primitive value of the specified object.
