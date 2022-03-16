# Markdown simple guide

---

## Table of contents

- [Heading](#heading)
- [Paragraphs](#paragraphs)
- [Font styles](#font-styles)
- [Blocks](#blocks)
- [Lists](#lists)
- [Images](#images)
- [Code](#code)
- [Links](#links)
- [Table](#table)

---

## Heading

# Heading level 1
## Heading level 2
### Heading level 3
#### Heading level 4
Regular text (between size 4 and 5)
##### Heading level 5
###### Heading level 6

---

## Paragraphs

Adding two spaces at the end  
you get a new line.

Your get a new paragraph after an empty line.

---

## Font styles

This is normal and **this is bold with two asterisks**

This is normal and __this is bold withtwo underscores__

This is normal and _this is italic_

This is normal and ~~this is strikethrough~~

All combined: ~~**_Bold+Italic+Strikethrough_**~~

---

## Blocks

Blockquote:

> Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi vitae ligula ex. Mauris nec enim sollicitudin lacus dignissim tincidunt. Sed imperdiet, ante eu commodo pharetra, ante lectus faucibus felis, quis pharetra justo nisl a leo. Sed ullamcorper, ligula vitae eleifend iaculis, tortor dui dignissim mauris, non aliquet lacus tortor ac.

---

## Lists

Ordered list

1. First level
2. Line 2
   1. Second level
   2. Line 2.2
   3. Line 2.3
      1. Thrid level
      2. Line 2.3.2
3. Line 3

Unordered Lists

- First level
- Line 2
   - Second level
   - Line 2.2
   - Line 2.3
      - Thrid level
      - Line 2.3.2
- Line 3

---

# Images

![alt text](https://avatars.githubusercontent.com/fin392?size=100 "Me")

---

# Code

```batch
:: For i=1 to 10 (step 1)...
FOR /L %i IN (1,1,10) DO CALL :Main_FOR_i %i
GOTO Main_ENDFOR_i
:Main_FOR_i

    ECHO Counting 1 to 10: %i

GOTO :EOF
:Main_ENDFOR_i
```

---

## Links

Link to [Lorem ipsum](https://www.lipsum.com/feed/html)

[Mail me](mailto:fin392@gmail.com)

---

# Table

| Normal | Centered text | Multi lines text | Numbers |
| --- | :---: | --- | ---: |
| Yes | TRUE | Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi vitae ligula ex. Mauris nec enim sollicitudin lacus dignissim tincidunt. Sed imperdiet, ante eu commodo pharetra, ante lectus faucibus felis, quis pharetra justo nisl a leo. Sed ullamcorper, ligula vitae eleifend iaculis, tortor dui dignissim mauris, non aliquet lacus tortor ac | 123,456.00 |
| No | FALSE | N/A | 1.99 |
| N/A  | N/A | N/A | 0.01 |
| Swearing | The truth, the whole truth, and nothing but the truth | N/A | 0.00 |

---
