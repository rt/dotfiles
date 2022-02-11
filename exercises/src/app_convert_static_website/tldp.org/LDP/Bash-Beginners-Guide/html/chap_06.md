::: {.NAVHEADER}
Bash Guide for Beginners
:::

[Prev](sect_05_05.md)

[Next](sect_06_01.md)

------------------------------------------------------------------------

::: {.chapter}
[]{#chap_06}Chapter 6. The GNU awk programming language
=======================================================

::: {.TOC}
**Table of Contents**

6.1. [Getting started with gawk](sect_06_01.md)

6.1.1. [What is gawk?](sect_06_01.md#sect_06_01_01)

6.1.2. [Gawk commands](sect_06_01.md#sect_06_01_02)

6.2. [The print program](sect_06_02.md)

6.2.1. [Printing selected fields](sect_06_02.md#sect_06_02_01)

6.2.2. [Formatting fields](sect_06_02.md#sect_06_02_02)

6.2.3. [The print command and regular
expressions](sect_06_02.md#sect_06_02_03)

6.2.4. [Special patterns](sect_06_02.md#sect_06_02_04)

6.2.5. [Gawk scripts](sect_06_02.md#sect_06_02_05)

6.3. [Gawk variables](sect_06_03.md)

6.3.1. [The input field separator](sect_06_03.md#sect_06_03_01)

6.3.2. [The output separators](sect_06_03.md#sect_06_03_02)

6.3.3. [The number of records](sect_06_03.md#sect_06_03_03)

6.3.4. [User defined variables](sect_06_03.md#sect_06_03_04)

6.3.5. [More examples](sect_06_03.md#sect_06_03_05)

6.3.6. [The printf program](sect_06_03.md#sect_06_03_06)

6.4. [Summary](sect_06_04.md)

6.5. [Exercises](sect_06_05.md)
:::

> ::: {.abstract}
> []{#AEN3998}
>
> In this chapter we will discuss:
>
> -   What is [gawk]{.application}?
>
> -   Using [gawk]{.application} commands on the command line
>
> -   How to format text with [gawk]{.application}
>
> -   How [gawk]{.application} uses regular expressions
>
> -   [Gawk]{.application} in scripts
>
> -   [Gawk]{.application} and variables
>
> ::: {.note}
> +-----------------------------------+-----------------------------------+
> | ![Note](http://tldp.org/LDP/Bash- | **To make it more fun**           |
> | Beginners-Guide/images/note.gif)  |                                   |
> +-----------------------------------+-----------------------------------+
> |                                   | As with **sed**, entire books     |
> |                                   | have been written about various   |
> |                                   | versions of **awk**. This         |
> |                                   | introduction is far from complete |
> |                                   | and is only intended for          |
> |                                   | understanding examples in the     |
> |                                   | following chapters. For more      |
> |                                   | information, best start with the  |
> |                                   | documentation that comes with     |
> |                                   | [GNU awk]{.application}: [\"GAWK: |
> |                                   | Effective AWK Programming: A      |
> |                                   | User\'s Guide for GNU             |
> |                                   | Awk\"]{.QUOTE}.                   |
> +-----------------------------------+-----------------------------------+
> :::
> :::
:::

::: {.NAVFOOTER}

------------------------------------------------------------------------

  ------------------------- -------------------- ---------------------------
  [Prev](sect_05_05.md)    [Home](index.md)      [Next](sect_06_01.md)
  Exercises                                        Getting started with gawk
  ------------------------- -------------------- ---------------------------
:::
