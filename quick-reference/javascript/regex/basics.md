https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Regular_Expressions

Regular expressions are used with the 

- RegExp methods test() and exec() 
- String methods match(), replace(), search(), and split(). 

When you want to know whether a pattern is found in a string
- test() or search()

for more information (but slower execution) use the 
- exec() or match()

If you use exec() or match() and if the match succeeds, these
methods return an array and update properties of the associated regular
expression object and also of the predefined regular expression object, RegExp. 

*Character classes*
```
\, ., \cX, \d, \D, \f, \n, \r, \s, \S, \t, \v, \w, \W, \0, \xhh, \uhhhh, \uhhhhh, [\b]	
```

*Assertions*
```
^, $, x(?=y), x(?!y), (?<=y)x, (?<!y)x, \b, \B	
```

*Groups and ranges*
```
(x), (?:x), (?<Name>x), x|y, [xyz], [^xyz], \Number	
```

*Quantifiers*
```
*, +, ?, x{n}, x{n,}, x{n,m}	
```

*Unicode property escapes*
```
\p{UnicodeProperty}, \P{UnicodeProperty}	
```

- exec()	Executes a search for a match in a string. It returns an array of information or null on a mismatch.
- test()	Tests for a match in a string. It returns true or false.
- match()	Returns an array containing all of the matches, including capturing groups, or null if no match is found.
- matchAll()	Returns an iterator containing all of the matches, including capturing groups.
- search()	Tests for a match in a string. It returns the index of the match, or -1 if the search fails.
- replace()	Executes a search for a match in a string, and replaces the matched substring with a replacement substring.
- replaceAll()	Executes a search for all matches in a string, and replaces the matched substrings with a replacement substring.
- split()	Uses a regular expression or a fixed string to break a string into an array of substrings.

