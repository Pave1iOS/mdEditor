import XCTest
@testable import MarkdownPackage

final class MarkdownToHtmlConverterTests: XCTestCase {
	func testExample() throws {

		let html = MarkdownToHtmlConverter().convert(markdownText: markdownText)
	}
}

private extension MarkdownToHtmlConverterTests {

	var markdownText: String {
"""
# 1. Headers

# h1
## h2
### h3
#### h4
##### h5
###### h6

## h2 test #tag

# 2. Text blocks

Lorem **ipsum** dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.
Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.

Text before line break
Text after line break

# 3. Quotes

> quote

>quote
>> nested **quote**

# 4. Code blocks

```
untyped code block
```

```
escaped chars in code:
\\```
```

```js
// js code
let a = 0
```

```python
# python code
print({"a":0})
```

# 5. lists

1. item-1
1. item-1
 1. item-1
 1. item-1
  - item
  - item

- item
 1. item-1
 2. item-2

# 6. Text decoration

*italic*

**bold**

***bold italic***

~~strikethrough~~

==highlighted==

`one line code`

# 7. Links

External link: [example.com](http://example.com)

Internal link: [[link to h1]]

# 8. Media

image:

![[15f4b6353310a9cd0ea994c7830b4c4c_MD5.jpeg|500]]

emoji: ⛺  😂‚

# 9. Tables

| title | title2 |
| --- | ---- |
| data | data2 |
| more data | more data2 |
| even more data | even more data2 |

# 10. other
## 10.1 Escaped special symbols

\\\\
\\`
\\*
\\_
\\{ \\}
\\[ \\]
\\< \\>
\\( \\)
\\#
\\+
\\-
\\.
\\!
\\|

## 10.2 Hline

___

---

##  Задачи

- [*] задача 1
- [*] задача 2
- [ ] задача 3
- [ ] задача 4
"""

	}
}
