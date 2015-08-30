---
title: Left-Middle-Right-Layout with Flexbox and Float ♦♦
subtitle: Centering is not that easey...
description: A quicktip on how to set up a layout with three elements and centering correctly.
tags: [tutorial, quicktip, sass, css, html, flexbox, ♦♦ ]
name: lmr-layout
category: en
---
### The Problem
I'm a big grid fan. A "left-middle-right"-layout is something I've used hundreds of times. But because I've mostly just worked with elements of the same width, I've never realized before, that it is actually not that easy, to _really_ center the middle element. So when I recently wanted to do the same thing with three buttons, I found out, that I had to figure out a new method.

But a solution was found and that's what I want to talk about today.

<br><!-- more -->
<p data-height="409" data-theme-id="7132" data-slug-hash="WvGdZL" data-default-tab="result" data-user="mynimi" class='codepen'>See the Pen <a href='http://codepen.io/mynimi/pen/WvGdZL/'>WvGdZL</a> by Myri (<a href='http://codepen.io/mynimi'>@mynimi</a>) on <a href='http://codepen.io'>CodePen</a>.</p>
<script async src="//assets.codepen.io/assets/embed/ei.js"></script>
<br>

As you can see in the example above the problem becomes obvious. The examples float1 and flex1 are written how I'd normally tackle this problem, because it's fast and easy. But if we increment the length of one of the sides you can see that the middle element is not really centered.

Before the middle element is centered, the width will be reduced on both sides and the element is centered within the space that's left.

In flexbox this is called `space-between`. The space between each of the elements is the same. It may be really helpful in some placed, but for this layout the second examples are what we want.

### Markup
Okay, for version 1 we need a very basic markup. A container and three subcontainers with the contents

```html
<div class="row"> <!-- here i'm addind the classes "float-1" or "flex-1" for each of the two examples -->
    <div class="left">left</div>
    <div class="center">center</div>
    <div class="right">right</div>
</div>
```

Then we'll add our CSS (I'm using Autoprefixer to take care of prefixing, so no prefixes in my CSS). Who wants to see the Sass is very welcome to go look at the CodePen.

Basically we style the container

```css
.row {
  position: relative;
  margin: 0 auto;
  width: 80%;
  max-width: 1400px;
}
```

Then for the float-version which I know a lot of people still would use first.

```css
/* for centering */
.float-1 {
  text-align: center;
}

/* clearfix */
.float-1:after {
  content: "";
  display: table;
  clear: both;
}

.float-1 .left {
  float: left;
}

.float-1 .right {
  float: right;
}

.float-1 .center {
  margin: 0 auto;
  display: inline-block;
  position: relative;
}
```

Alternatively the solution is flexbox is much shorter and less probable to break something else. So that's the solution I will go for. With a Sass mixin this step only takes me 3 lines.

```css
.flex-1 {
  display: flex;
  flex-direction: row;
  flex-wrap: wrap;
  justify-content: space-between;
  align-items: center;
}
```

So you can see that this version breaks. To stabilise it, I had a pretty simple idea.

### The Solution

The idea is to take containers of the same size. If all of the elements are the same width, you can align the content within easily. The inner markup needs a little bit of an adjustments then.

```html
<span class="left"><span>left</span></span>
<span class="center"><span>center</span></span>
<span class="right"><span>right</span></span>
```

And in CSS it looks like that:

**float**

```css
.float-2 {
  text-align: center;
}
/* clearfix */
.float-2:after {
  content: "";
  display: table;
  clear: both;
}

/* common width (100% / 3) */
.float-2 span {
  width: 33.33333%;
}

/* floats */
.float-2 .left {
  float: left;
}
.float-2 .right {
  float: right;
}

/* alignment */
.float-2 span:nth-of-type(1) {
  text-align: left;
}
.float-2 span:nth-of-type(2) {
  text-align: center;
}
.float-2 span:nth-of-type(3) {
  text-align: right;
}
```

**flexbox**

```css
.flex-2 {
  display: flex;
  flex-direction: row;
  flex-wrap: wrap;
  justify-content: flex-start;
  align-items: center;
}

/* flex: 1 sais, that each of the elements shall get the same amount of space, ergo the same width */
.flex-2 span {
  flex: 1;
}

/* alignment */
.flex-2 span:nth-of-type(1) {
  text-align: left;
}
.flex-2 span:nth-of-type(2) {
  text-align: center;
}
.flex-2 span:nth-of-type(3) {
  text-align: right;
}

```

And that's it. And the centering looks balanced.