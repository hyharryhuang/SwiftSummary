# SwiftSummary
Naive summary algorithm inspired by a [Python implementation](https://gist.github.com/shlomibabluki/5473521). Summarises a block of text based on its paragraphs.

# Installation
Copy `SwiftSummary.swift` to your project.

# Usage
```swift
let summary = Summary()

var title = "This is the article title"
var content = "Some article content"

var summarisedContent = summary.getSummary(title, content: content)
```

# Example
This [TechCrunch article](http://techcrunch.com/2015/01/19/qwerky/) is summarised to:
```text
Qwerky Keyboard Speeds Up Typing Emoji On iOS

Since then we’ve seen a raft of alternative iOS keyboard apps popping up to try to garner a following.

With our keyboard, swiping left and right quickly navigates from text to emojis,” says  co-founder Ed Moyse, explaining what problem the Qwerky team set out to fix.

Such as if you type ‘saturdaynight’ the keyboard will sub out your letters for an emoji version of John Travolta (pictured at the top of this post).

But Qwerky is hoping it’s focus on speed and simplicity will help the app stand out in a crowded space.

“We’re aiming to stand out/convince people to stay by offering a keyboard that lets you type like a human,” says Moyse.

So yes, this is absolutely about cashing in on teens wanting to send pictures of cash to each other.

So depending on how much you lean on Apple’s (or others’) next word suggestion algorithms to speed your typing you might actually find it slower to bash out words on Qwerky.
```
