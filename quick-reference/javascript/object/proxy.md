```javascript
const target = {
  notProxied: "original value",
  proxied: "original value"
};

const handler = {
  get: function(target, prop, receiver) {
    if (prop === "proxied") {
      return "replaced value";
    }
    return Reflect.get(...arguments);
  }
};

const proxy = new Proxy(target, handler);
// const revocableProxy = new Proxy.revocable(target, handler);

console.log(proxy.notProxied); // "original value"
console.log(proxy.proxied);    // "replaced value"

// revocableProxy.revoke();
// back to normal ...
```

`handler.apply()`: A trap for a function call.

`handler.construct()`: A trap for the new operator.

`handler.defineProperty()`: A trap for Object.defineProperty.

`handler.deleteProperty()`: A trap for the delete operator.

`handler.get()`: A trap for getting property values.

`handler.getOwnPropertyDescriptor()`: A trap for Object.getOwnPropertyDescriptor.

`handler.getPrototypeOf()`: A trap for Object.getPrototypeOf.

`handler.has()`: A trap for the in operator.

`handler.isExtensible()`: A trap for Object.isExtensible.

`handler.ownKeys()`: A trap for Object.getOwnPropertyNames and Object.getOwnPropertySymbols.

`handler.preventExtensions()`: A trap for Object.preventExtensions.

`handler.set()`: A trap for setting property values.

`handler.setPrototypeOf()`: A trap for Object.setPrototypeOf.
