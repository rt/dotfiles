::: {.BOOK}
[]{#AEN1}

::: {.TITLEPAGE}
### []{#AEN5}Machtelt Garrels {#machtelt-garrels .author}

::: {.affiliation}
[Garrels BVBA\
]{.orgname}

::: {.address}
\
`<tille wants no spam _at_ garrels dot be>`{.email}\
:::
:::

Version 1.11 Last updated 20081227 Edition

------------------------------------------------------------------------
:::

::: {.TOC}
**Table of Contents**

[Introduction](f32.md)

1\. [Why this guide?](intro_01.md)

2\. [Who should read this book?](intro_02.md)

3\. [New versions, translations and availability](intro_03.md)

4\. [Revision History](intro_04.md)

5\. [Contributions](intro_05.md)

6\. [Feedback](intro_06.md)

7\. [Copyright information](intro_07.md)

8\. [What do you need?](intro_08.md)

9\. [Conventions used in this document](intro_09.md)

10\. [Organization of this document](intro_10.md)

1\. [Bash and Bash scripts](chap_01.md)

1.1. [Common shell programs](sect_01_01.md)

1.2. [Advantages of the Bourne Again SHell](sect_01_02.md)

1.3. [Executing commands](sect_01_03.md)

1.4. [Building blocks](sect_01_04.md)

1.5. [Developing good scripts](sect_01_05.md)

1.6. [Summary](sect_01_06.md)

1.7. [Exercises](sect_01_07.md)

2\. [Writing and debugging scripts](chap_02.md)

2.1. [Creating and running a script](sect_02_01.md)

2.2. [Script basics](sect_02_02.md)

2.3. [Debugging Bash scripts](sect_02_03.md)

2.4. [Summary](sect_02_05.md)

2.5. [Exercises](sect_02_06.md)

3\. [The Bash environment](chap_03.md)

3.1. [Shell initialization files](sect_03_01.md)

3.2. [Variables](sect_03_02.md)

3.3. [Quoting characters](sect_03_03.md)

3.4. [Shell expansion](sect_03_04.md)

3.5. [Aliases](sect_03_05.md)

3.6. [More Bash options](sect_03_06.md)

3.7. [Summary](sect_03_07.md)

3.8. [Exercises](sect_03_08.md)

4\. [Regular expressions](chap_04.md)

4.1. [Regular expressions](sect_04_01.md)

4.2. [Examples using grep](sect_04_02.md)

4.3. [Pattern matching using Bash features](sect_04_03.md)

4.4. [Summary](sect_04_04.md)

4.5. [Exercises](sect_04_05.md)

5\. [The GNU sed stream editor](chap_05.md)

5.1. [Introduction](sect_05_01.md)

5.2. [Interactive editing](sect_05_02.md)

5.3. [Non-interactive editing](sect_05_03.md)

5.4. [Summary](sect_05_04.md)

5.5. [Exercises](sect_05_05.md)

6\. [The GNU awk programming language](chap_06.md)

6.1. [Getting started with gawk](sect_06_01.md)

6.2. [The print program](sect_06_02.md)

6.3. [Gawk variables](sect_06_03.md)

6.4. [Summary](sect_06_04.md)

6.5. [Exercises](sect_06_05.md)

7\. [Conditional statements](chap_07.md)

7.1. [Introduction to if](sect_07_01.md)

7.2. [More advanced if usage](sect_07_02.md)

7.3. [Using case statements](sect_07_03.md)

7.4. [Summary](sect_07_04.md)

7.5. [Exercises](sect_07_05.md)

8\. [Writing interactive scripts](chap_08.md)

8.1. [Displaying user messages](sect_08_01.md)

8.2. [Catching user input](sect_08_02.md)

8.3. [Summary](sect_08_03.md)

8.4. [Exercises](sect_08_04.md)

9\. [Repetitive tasks](chap_09.md)

9.1. [The for loop](sect_09_01.md)

9.2. [The while loop](sect_09_02.md)

9.3. [The until loop](sect_09_03.md)

9.4. [I/O redirection and loops](sect_09_04.md)

9.5. [Break and continue](sect_09_05.md)

9.6. [Making menus with the select built-in](sect_09_06.md)

9.7. [The shift built-in](sect_09_07.md)

9.8. [Summary](sect_09_08.md)

9.9. [Exercises](sect_09_09.md)

10\. [More on variables](chap_10.md)

10.1. [Types of variables](sect_10_01.md)

10.2. [Array variables](sect_10_02.md)

10.3. [Operations on variables](sect_10_03.md)

10.4. [Summary](sect_10_04.md)

10.5. [Exercises](sect_10_05.md)

11\. [Functions](chap_11.md)

11.1. [Introduction](sect_11_01.md)

11.2. [Examples of functions in scripts](sect_11_02.md)

11.3. [Summary](sect_11_03.md)

11.4. [Exercises](sect_11_04.md)

12\. [Catching signals](chap_12.md)

12.1. [Signals](sect_12_01.md)

12.2. [Traps](sect_12_02.md)

12.3. [Summary](sect_12_03.md)

12.4. [Exercises](sect_12_04.md)

A. [Shell Features](app3.md)

A.1. [Common features](x7243.md)

A.2. [Differing features](x7369.md)

[Glossary](gloss.md)

[Index](glossary.md)
:::

::: {.LOT}
**List of Tables**

1\. [Typographic and usage conventions](intro_09.md#conventions)

1-1. [Overview of programming terms](sect_01_05.md#table_01_01)

2-1. [Overview of set debugging options](sect_02_03.md#table_02_01)

3-1. [Reserved Bourne shell variables](sect_03_02.md#table_03_01)

3-2. [Reserved Bash variables](sect_03_02.md#table_03_02)

3-3. [Special bash variables](sect_03_02.md#table_03_03)

3-4. [Arithmetic operators](sect_03_04.md#table_03_04)

4-1. [Regular expression operators](sect_04_01.md#table_04_01)

5-1. [Sed editing commands](sect_05_01.md#tab_05_01)

5-2. [Sed options](sect_05_01.md#tab_05_02)

6-1. [Formatting characters for gawk](sect_06_02.md#tab_06_01)

7-1. [Primary expressions](sect_07_01.md#tab_07_01)

7-2. [Combining expressions](sect_07_01.md#tab_07_02)

8-1. [Escape sequences used by the echo
command](sect_08_01.md#tab_08_01)

8-2. [Options to the read built-in](sect_08_02.md#tab_08_02)

10-1. [Options to the declare built-in](sect_10_01.md#tab_10_01)

12-1. [Control signals in Bash](sect_12_01.md#tab_12_01)

12-2. [Common kill signals](sect_12_01.md#tab_12_02)

A-1. [Common Shell Features](x7243.md#AEN7246)

A-2. [Differing Shell Features](x7369.md#AEN7387)
:::

::: {.LOT}
**List of Figures**

1\. [Bash Guide for Beginners front cover](intro_03.md#AEN71)

2-1. [script1.sh](sect_02_01.md#AEN1409)

3-1. [Different prompts for different users](sect_03_01.md#AEN1878)

6-1. [Fields in awk](sect_06_02.md#AEN4111)

7-1. [Testing of a command line argument with
if](sect_07_02.md#AEN5029)

7-2. [Example using Boolean operators](sect_07_02.md#AEN5144)
:::
:::

::: {.NAVFOOTER}

------------------------------------------------------------------------

  --- --- ------------------
            [Next](f32.md)
                Introduction
  --- --- ------------------
:::
