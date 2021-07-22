https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Regular_Expressions/Unicode_Property_Escapes

Unicode property escapes Regular Expressions allows for matching characters
based on their Unicode properties. A character is described by several
properties which are either binary ("boolean-like") or non-binary. For
instance, unicode property escapes can be used to match emojis, punctuations,
letters (even letters from specific languages or scripts), etc.

```javascript
// Non-binary values
\p{UnicodePropertyValue}
\p{UnicodePropertyName=UnicodePropertyValue}

// Binary and non-binary values
\p{UnicodeBinaryPropertyName}

// Negation: \P is negated \p
\P{UnicodePropertyValue}
\P{UnicodeBinaryPropertyName}
```

`UnicodeBinaryPropertyName`

The name of a binary property. E.g.: ASCII, Alpha, Math, Diacritic, Emoji,
Hex_Digit, Math, White_space, etc. See Unicode Data PropList.txt for more info.

`UnicodePropertyName`

The name of a non-binary property:

`UnicodePropertyValue`

One of the tokens listed in the Values section, below. Many values have aliases
or shorthand (e.g. the value Decimal_Number for the General_Category property
may be written Nd, digit, or Decimal_Number). For most values, the
UnicodePropertyName part and equals sign may be omitted. If a
UnicodePropertyName is specified, the value must correspond to the property
type given.
