::: {.NAVHEADER}
Bash Guide for Beginners
:::

[Prev](sect_02_06.md)

[Next](sect_03_01.md)

------------------------------------------------------------------------

::: {.chapter}
[]{#chap_03}Chapter 3. The Bash environment
===========================================

::: {.TOC}
**Table of Contents**

3.1. [Shell initialization files](sect_03_01.md)

3.1.1. [System-wide configuration files](sect_03_01.md#sect_03_01_01)

3.1.2. [Individual user configuration
files](sect_03_01.md#sect_03_01_02)

3.1.3. [Changing shell configuration
files](sect_03_01.md#sect_03_01_03)

3.2. [Variables](sect_03_02.md)

3.2.1. [Types of variables](sect_03_02.md#sect_03_02_01)

3.2.2. [Creating variables](sect_03_02.md#sect_03_02_02)

3.2.3. [Exporting variables](sect_03_02.md#sect_03_02_03)

3.2.4. [Reserved variables](sect_03_02.md#sect_03_02_04)

3.2.5. [Special parameters](sect_03_02.md#sect_03_02_05)

3.2.6. [Script recycling with variables](sect_03_02.md#sect_03_02_06)

3.3. [Quoting characters](sect_03_03.md)

3.3.1. [Why?](sect_03_03.md#sect_03_03_01)

3.3.2. [Escape characters](sect_03_03.md#sect_03_03_02)

3.3.3. [Single quotes](sect_03_03.md#sect_03_03_03)

3.3.4. [Double quotes](sect_03_03.md#sect_03_03_04)

3.3.5. [ANSI-C quoting](sect_03_03.md#sect_03_03_05)

3.3.6. [Locales](sect_03_03.md#sect_03_03_06)

3.4. [Shell expansion](sect_03_04.md)

3.4.1. [General](sect_03_04.md#sect_03_04_0)

3.4.2. [Brace expansion](sect_03_04.md#sect_03_04_01)

3.4.3. [Tilde expansion](sect_03_04.md#sect_03_04_02)

3.4.4. [Shell parameter and variable
expansion](sect_03_04.md#sect_03_04_03)

3.4.5. [Command substitution](sect_03_04.md#sect_03_04_04)

3.4.6. [Arithmetic expansion](sect_03_04.md#sect_03_04_05)

3.4.7. [Process substitution](sect_03_04.md#sect_03_04_06)

3.4.8. [Word splitting](sect_03_04.md#sect_03_04_07)

3.4.9. [File name expansion](sect_03_04.md#sect_03_04_08)

3.5. [Aliases](sect_03_05.md)

3.5.1. [What are aliases?](sect_03_05.md#sect_03_05_01)

3.5.2. [Creating and removing aliases](sect_03_05.md#sect_03_05_02)

3.6. [More Bash options](sect_03_06.md)

3.6.1. [Displaying options](sect_03_06.md#sect_03_06_01)

3.6.2. [Changing options](sect_03_06.md#sect_03_06_02)

3.7. [Summary](sect_03_07.md)

3.8. [Exercises](sect_03_08.md)
:::

> ::: {.abstract}
> []{#AEN1676}
>
> In this chapter we will discuss the various ways in which the Bash
> environment can be influenced:
>
> -   Editing shell initialization files
>
> -   Using variables
>
> -   Using different quote styles
>
> -   Perform arithmetic calculations
>
> -   Assigning aliases
>
> -   Using expansion and substitution
> :::
:::

::: {.NAVFOOTER}

------------------------------------------------------------------------

  ------------------------- -------------------- ----------------------------
  [Prev](sect_02_06.md)    [Home](index.md)       [Next](sect_03_01.md)
  Exercises                                        Shell initialization files
  ------------------------- -------------------- ----------------------------
:::
