::: {.NAVHEADER}
Bash Guide for Beginners
:::

[Prev](sect_04_05.md)

[Next](sect_05_01.md)

------------------------------------------------------------------------

::: {.chapter}
[]{#chap_05}Chapter 5. The GNU sed stream editor
================================================

::: {.TOC}
**Table of Contents**

5.1. [Introduction](sect_05_01.md)

5.1.1. [What is sed?](sect_05_01.md#sect_05_01_01)

5.1.2. [sed commands](sect_05_01.md#sect_05_01_02)

5.2. [Interactive editing](sect_05_02.md)

5.2.1. [Printing lines containing a
pattern](sect_05_02.md#sect_05_02_01)

5.2.2. [Deleting lines of input containing a
pattern](sect_05_02.md#sect_05_02_02)

5.2.3. [Ranges of lines](sect_05_02.md#sect_05_02_03)

5.2.4. [Find and replace with sed](sect_05_02.md#sect_05_02_04)

5.3. [Non-interactive editing](sect_05_03.md)

5.3.1. [Reading sed commands from a file](sect_05_03.md#sect_05_03_01)

5.3.2. [Writing output files](sect_05_03.md#sect_05_03_02)

5.4. [Summary](sect_05_04.md)

5.5. [Exercises](sect_05_05.md)
:::

> ::: {.abstract}
> []{#AEN3619}
>
> At the end of this chapter you will know about the following topics:
>
> -   What is **sed**?
>
> -   Interactive use of **sed**
>
> -   Regular expressions and stream editing
>
> -   Using **sed** commands in scripts
>
> ::: {.note}
> +-----------------------------------+-----------------------------------+
> | ![Note](http://tldp.org/LDP/Bash- | **This is an introduction**       |
> | Beginners-Guide/images/note.gif)  |                                   |
> +-----------------------------------+-----------------------------------+
> |                                   | These explanations are far from   |
> |                                   | complete and certainly not meant  |
> |                                   | to be used as the definite user   |
> |                                   | manual for **sed**. This chapter  |
> |                                   | is only included in order to show |
> |                                   | some more interesting topics in   |
> |                                   | the next chapters, and because    |
> |                                   | every power user should have a    |
> |                                   | basic knowledge of things that    |
> |                                   | can be done with this editor.     |
> |                                   |                                   |
> |                                   | For detailed information, refer   |
> |                                   | to the **sed** info and man       |
> |                                   | pages.                            |
> +-----------------------------------+-----------------------------------+
> :::
> :::
:::

::: {.NAVFOOTER}

------------------------------------------------------------------------

  ------------------------- -------------------- -------------------------
  [Prev](sect_04_05.md)    [Home](index.md)    [Next](sect_05_01.md)
  Exercises                                                   Introduction
  ------------------------- -------------------- -------------------------
:::
