`x|y`	

Matches either "x" or "y". For example, /green|red/ matches "green" in "green
apple" and "red" in "red apple".

`[xyz], [a-c]`

A character class. Matches any one of the enclosed characters. You can specify
a range of characters by using a hyphen, but if the hyphen appears as the first
or last character enclosed in the square brackets it is taken as a literal
hyphen to be included in the character class as a normal character.

For example, [abcd] is the same as [a-d]. They match the "b" in "brisket"
For example, [abcd-] and [-abcd] match the "-" (hyphen) in "non-profit".
For example, [\w-] is the same as [A-Za-z0-9_-]. 

`[^xyz], [^a-c]`

A negated or complemented character class. That is, it matches anything that is
not enclosed in the brackets. You can specify a range of characters by using a
hyphen, but if the hyphen appears as the first or last character enclosed in
the square brackets it is taken as a literal hyphen to be included in the
character class as a normal character. For example, [^abc] is the same as
[^a-c]. They initially match "o" in "bacon" and "h" in "chop".

`(x)`

Capturing group: Matches x and remembers the match. For example, /(foo)/
matches and remembers "foo" in "foo bar". 

A regular expression may have multiple capturing groups. In results, matches to
capturing groups typically in an array whose members are in the same order as
the left parentheses in the capturing group. This is usually just the order of
the capturing groups themselves. This becomes important when capturing groups
are nested. Matches are accessed using the index of the result's elements ([1],
..., [n]) or from the predefined RegExp object's properties ($1, ..., $9).

Capturing groups have a performance penalty. If you don't need the matched
substring to be recalled, prefer non-capturing parentheses (see below).

String.match() won't return groups if the /.../g flag is set. However, you can
still use String.matchAll() to get all matches.

`\n`	

Where "n" is a positive integer. A back reference to the last substring
matching the n parenthetical in the regular expression (counting left
parentheses). For example, /apple(,)\sorange\1/ matches "apple, orange," in
"apple, orange, cherry, peach".

`\k<Name>`

A back reference to the last substring matching the Named capture group
specified by <Name>.

For example, /(?<title>\w+), yes \k<title>/ matches "Sir, yes Sir" in "Do you
copy? Sir, yes Sir!".

Note: \k is used literally here to indicate the beginning of a back reference
to a Named capture group.

`(?<Name>x)`	

Named capturing group: Matches "x" and stores it on the groups property of the
returned matches under the name specified by <Name>. The angle brackets (< and
>) are required for group name.

For example, to extract the United States area code from a phone number, we
could use /\((?<area>\d\d\d)\)/. The resulting number would appear under
matches.groups.area.

(?:x)	Non-capturing group: Matches "x" but does not remember the match. The
matched substring cannot be recalled from the resulting array's elements ([1],
..., [n]) or from the predefined RegExp object's properties ($1, ..., $9).
