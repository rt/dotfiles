# navigation


Probably should make some keyboard layers ...

Main thing is vim-sexp-mappings-for-regular-people replaces the meta <M-> bindings out and other stuff (mappings inspired from surround.vim)

**fireplace**
https://github.com/tpope/vim-fireplace

```text
:Source
:Doc
:FindDoc
K             mapped to doc for symbol under cursor
[d            mapped to source for symbol under cursor
[<C-D>        jumps to the definition of a symbol
<C-]>         does the same and uses the tag stack
gf            "go to file", works on namespaces
```

*Evaluating*

```text
:Eval         evaluates a range (:%Eval gets the whole file)
:Require      requires a namespace with :reload (:Require! does :reload-all)
:RunTests     kicks off (clojure.test/run-tests) and loads results into the quickfix list
```

**vim-sexp** + **vim-sexp-mappings-for-regular-people**
https://github.com/guns/vim-sexp
https://github.com/tpope/vim-sexp-mappings-for-regular-people



*Text Object Selections (visual, operator-pending)*
Text object selections refer to text around the cursor.

The af and if objects select COMPOUND FORMS.
The aF and iF objects select top-level COMPOUND FORMS.
The as and is objects select STRINGS.
The ae and ie objects select ELEMENTS.

*Text Object Motions (normal, visual, operator-pending)*

Text object motions move the cursor in normal mode, extend selections in visual
mode, and refer to text defined by the movement of the cursor in
operator-pending mode.

The ( and ) motions move the cursor to the nearest paired structural bracket.
The B and W motions move the cursor ELEMENT-wise, ending on an element head. 
The gE and E motions move the cursor ELEMENT-wise, ending on an element tail. 
The [[ and ]] motions move the cursor to an adjacent top-level ELEMENT.
The [e and ]e mappings select an adjacent ELEMENT.

*Indent Commands (normal)*
== indents the current COMPOUND FORM without moving the cursor
=- indents the current top-level COMPOUND FORM without moving the cursor

*Wrap Commands (normal, visual)*

Wrap commands wrap the current COMPOUND FORM, ELEMENT, or visual selection and
place the cursor at the head or tail of the newly created COMPOUND FORM.

If g:sexp_insert_after_wrap is set (true by default), insert mode is entered after wrapping.

✓ <LocalLeader>i and <LocalLeader>I wrap the current COMPOUND FORM with ( and ).
  or, ysaf(
✓ <LocalLeader>[ and <LocalLeader>] wrap the current COMPOUND FORM with [ and ].
  or, ysaf[
✓ <LocalLeader>{ and <LocalLeader>} wrap the current COMPOUND FORM with { and }.
  or, ysaf{
✓ <LocalLeader>W and <LocalLeader>w wrap the current ELEMENT with ( and ).
  or, cse(
✓ <LocalLeader>e[ and <LocalLeader>e] wrap the current ELEMENT with [ and ].
  or, cse[
✓ <LocalLeader>e{ and <LocalLeader>e} wrap the current ELEMENT with { and }.
  or, cse{

*List Manipulation (normal, visual)*
List manipulation commands change the structure of COMPOUND FORMS. If these commands are called from visual mode, the selection is used in place of the current COMPOUND FORM or ELEMENT.

```
✓ <LocalLeader>@ splices the current COMPOUND FORM into its parent.
  or, dsf
✓ <LocalLeader>o raises the current COMPOUND FORM to replace the enclosing COMPOUND FORM.
✓ <LocalLeader>O raises the current ELEMENT to replace the enclosing COMPOUND FORM.
✓ >f and <f swap the position of the current COMPOUND FORM with a sibling ELEMENT.
✓ >e and <e swap the position of the current ELEMENT with a sibling ELEMENT.
✓ <), >( emit/barfage the terminal ELEMENTS of the current COMPOUND FORM.
✓ >), <( capture/slurpage adjacent ELEMENTS into the current COMPOUND FORM.
```

*Cursor Insertion (normal)*

```bash
<LocalLeader>h inserts the cursor at the head of the current COMPOUND FORM
  or, <I
<LocalLeader>l inserts the cursor at the tail of the current COMPOUND FORM
  or, >I
```

If inserting at the head, a space is conditionally appended after the opening
bracket so that any typed characters will be separated from the next element.



*Insert Mode Mappings (insert)*
Vim-sexp does intelligent bracket and double quote insertion like paredit.el. Unlike ParEdit, deletion of brackets that would cause an imbalance is not prevented, except in the limited case of <BS> below.

(, [, and { produce a closing bracket and also insert spaces as necessary to separate the new COMPOUND FORM from adjacent non-compound ELEMENTS.
), ], and } insert closing brackets when the corresponding opening bracket is unpaired. If the opening bracket is paired, jump to the next paired instance of the closing bracket.
" inserts a pair of double quotes, unless the cursor is currently in a STRING.
<BS> deletes an adjacent pair of (), [], {}, and "" when deleting the opening bracket or quote. Normal backspace otherwise.
These insert mode mappings can be disabled with:

let g:sexp_enable_insert_mode_mappings = 0

