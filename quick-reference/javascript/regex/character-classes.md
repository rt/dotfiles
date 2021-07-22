`.`	

- Matches any single character except line terminators: \n, \r, \u2028 or \u2029. For example, /.y/ matches "my" and "ay", but not "yes", in "yes make my day".
- Inside a character class, the dot loses its special meaning and matches a literal dot.

Note that the m multiline flag doesn't change the dot behavior. So to match a
pattern across multiple lines, the character class [^] can be used — it will
match any character including newlines.

ES2018 added the s "dotAll" flag, which allows the dot to also match line
terminators.

`\d`	

Matches any digit (Arabic numeral). Equivalent to [0-9]. For example, /\d/ or
/[0-9]/ matches "2" in "B2 is the suite number".

`\D`

Matches any character that is not a digit (Arabic numeral). Equivalent to
[^0-9]. For example, /\D/ or /[^0-9]/ matches "B" in "B2 is the suite number".

`\w`

Matches any alphanumeric character from the basic Latin alphabet, including the
underscore. Equivalent to [A-Za-z0-9_]. For example, /\w/ matches "a" in
"apple", "5" in "$5.28", "3" in "3D" and "m" in "Émanuel".

`\W`

Matches any character that is not a word character from the basic Latin
alphabet. Equivalent to [^A-Za-z0-9_]. For example, /\W/ or /[^A-Za-z0-9_]/
matches "%" in "50%" and "É" in "Émanuel".

`\s`

Matches a single white space character, including space, tab, form feed, line
feed, and other Unicode spaces. Equivalent to [
\f\n\r\t\v\u00a0\u1680\u2000-\u200a\u2028\u2029\u202f\u205f\u3000\ufeff]. For
example, /\s\w*/ matches " bar" in "foo bar".

`\S`

Matches a single character other than white space. Equivalent to [^
\f\n\r\t\v\u00a0\u1680\u2000-\u200a\u2028\u2029\u202f\u205f\u3000\ufeff]. For
example, /\S\w*/ matches "foo" in "foo bar".

`\t`	Matches a horizontal tab.
`\r`	Matches a carriage return.
`\n`	Matches a linefeed.
`\v`	Matches a vertical tab.
`\f`	Matches a form-feed.
`[\b]`	Matches a backspace. If you're looking for the word-boundary character (\b), see Assertions.
`\0`	Matches a NUL character. Do not follow this with another digit.

`\cX`

Matches a control character using caret notation, where "X" is a letter from
A–Z (corresponding to codepoints U+0001–U+001F). For example, /\cM/ matches
"\r" in "\r\n".

`\xhh`	Matches the character with the code hh (two hexadecimal digits).
`\uhhhh`	Matches a UTF-16 code-unit with the value hhhh (four hexadecimal digits).
`\u{hhhh} or \u{hhhhh}`	(Only when the u flag is set.) Matches the character with the Unicode value U+hhhh or U+hhhhh (hexadecimal digits).

`\p{UnicodeProperty}, \P{UnicodeProperty}`	

Matches a character based on its Unicode character properties (to match just,
for example, emoji characters, or Japanese katakana characters, or
Chinese/Japanese Han/Kanji characters, etc.).

`\`	

Indicates that the following character should be treated specially, or
"escaped". It behaves one of two ways.

For characters that are usually treated literally, indicates that the next
character is special and not to be interpreted literally. For example, /b/
matches the character "b". By placing a backslash in front of "b", that is by
using /\b/, the character becomes special to mean match a word boundary.

For characters that are usually treated specially, indicates that the next
character is not special and should be interpreted literally. For example, "*"
is a special character that means 0 or more occurrences of the preceding
character should be matched; for example, /a*/ means match 0 or more "a"s. To
match * literally, precede it with a backslash; for example, /a\*/ matches
"a*".

Note: To match this character literally, escape it with itself. In other words
to search for \ use /\\/.
