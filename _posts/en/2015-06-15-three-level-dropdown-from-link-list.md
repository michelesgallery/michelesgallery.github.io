---
date: 2015-06-15 17:11:12 +0200
title: Responsive Blogger Menus&colon; 3-Level dropdown from list ♦♦
name: RBM3DaL
subtitle: A dropdown menu without coding skills
tags: [dropdown, blogger, navigation, tutorial, ♦♦, javascript, jquery]
description: How to generate a 3-level dropdown menu from a link list in blogger.
category: en
---
When I first started creating responsive Websites, navigation was always one of the hardest things to accomplish. Because of that, I almost always went with Bootstrap. But using a pretty huge framework for something pretty small like a menu pretty soon started bothering me. So I searched for tutorials on how to write a responsive menu and soon started, to write my own, because there was almost always something that I did not like.

For all of you out there that are in the same position I was, when I started, I created this menu. It is a three level navigation, that will be generated from a simple link list.

<br>
<!-- more -->
<p data-height="304" data-theme-id="7132" data-slug-hash="NPOKYP" data-default-tab="result" data-user="mynimi" class='codepen'>See the Pen <a href='http://codepen.io/mynimi/pen/NPOKYP/'>3-Level Dropdown from 1-Level Menu</a> by Myri (<a href='http://codepen.io/mynimi'>@mynimi</a>) on <a href='http://codepen.io'>CodePen</a>.</p>
<script async src="//assets.codepen.io/assets/embed/ei.js"></script>

In this Tutorial I don't want to go over how this menu works, but how to integrate it into the blog (I do plan on writing a tutorial on the dropdown, though).

It is always best to test something new in a testblog, before you put it on your live blog, even though this should work out in most cases at the first try. 
Also, since this is a responsive menu, you should use a responsive template. If you don't have one and don't feel like writing your own, you are very welcome to take a look at some of [my templates](/themes/).

Okay, log into blogger and let's get started.

### 1. Create Linklist
First open the layout tab of your blog and create a new link list. It does not matter where you put it, since the navigation will be fixed anyways. But because I'd like to mention some logic, I would place it somewhere around the top.

Now on how you build your link list. Order does matter here.

Subelements for the second level start with an `_`and elements of the third level, start with two underscores `__` For the correct order, you need to put the grandchildren underneath the children and the children below the parent.

```html
parentlink
_childlink
__grandchildlink
```

Save.

![linkliste]({{ site.img_dir }}/blogger-linklist.png)

### 2. Sass and Script Personalization.

Now personalize the dropdown.

The first thing you want to find out though is how the list is called.

So you want to inspect the element with the inspector that ships with every good browser. (right-click, inspect element).

If you just have one linklist within your blog, you can work with the class. But since the linklist widget is pretty popular, and you don't want to cause any confusion, it is easiest to work with the ID.

So go check it out. For me the Id is `LinkList1`

![inspector ID]({{ site.img_dir }}/blogger-menu-id.jpg)

Next open my [CodePen](http://codepen.io/mynimi/pen/NPOKYP)

YOu don't have to make any changes within my javascript, if you want to use my CSS and are happy with the way I've named the classes. But there are two variables, you should/can customize.

Search for

```js
// SETTINGS
//------------------------------------------------------    
var one_level_list_element = $('ul'), // mandatory!
    menu_name = 'Menu', // this will be used next to the hamburger icon for the toggle Button
```

You should replace the first `$('ul)` with the correct identifier of your linklist. The second variable is how you want the button to be called in the responsive view. In the example I wanted to change that to "Navigation"
So after my changes are done, that's how it looks like:

```js
// SETTINGS
//------------------------------------------------------    
var one_level_list_element = $('#LinkList1 ul'), // mandatory!
    menu_name = 'Navigation', // this will be used next to the hamburger icon for the toggle Button
```

Since the styles are written in Sass, it is very easy to customize. I did explain all of the variables, so it should be easy to adjust.

```scss
// Menu Collapse, change to something above viewport width to see responsive version
$toggle: 700px;

// Main Bar Background Color
$menu_bg: #B50A50;

// Link Color and Hover
$menu_color: white;
$item_hover_color: lighten($menu_bg, 75%);

// Drop Down Opener (Arrow Links)
$arrow_toggle_line: 1px solid rgba(white, .1);
$arrow_toggle_hover_bg: rgba(white, .1);
$arrow_toggle_color: white;

// Level Two Background and Background on hover
$level-two_bg: $menu_bg;
$level-two_hover_bg: rgba(white, .1);

// Level Three Background and Background on hover
$level-three_bg: $menu_bg;
$level-three_hover_bg: rgba(white, .1);

// Menu Text Alignment use[left, center, right]
$text_align: left; 

// Responsive Toggle Link
$responsive_width: 100%;
$responsive_toggle_text_align: left;
$navtoggle_bg: #291018;
$navtoggle_color: white;
$navtoggle_hover_color: lighten(#291018, 80%);
```

As soon as you adjusted the colors, you are ready to put together your HTML widget.

### 3. Add HTML Widget

Okay, what is all going into the widget?

The menu depends on Font Awesome Icons, so that's what I'll add in there as well. And because the js was written in jQuery, you want to make sure, that that's added as well. If it is already part of your blog, you don't need to add it again, though.

I just put everything in a HTML widget, but if you are not afraid of your code, feel free to add it in the respective places within the template.

Copy all of the javascript.
For the CSS, you click on _view compiled_ and get the generated CSS.
Then look for:

```css
/* Copy Everything Below This Line */
```

And copy everything below that line, as per instructions.

An that's the content of your HTML widget.

```html
<!-- Font Awesome -->
<link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css">
<style>
    /* Add CSS here */
</style>

<!--jQuery-->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script>
    // and javascript here
</script>
```

### 4. Troubleshoot

Sometimes Blogger likes to be annoying.

If something does not work out as expected, it might be because the CSS of the widget is interfering with the new CSS:

In that case take your ID of the linklist again and add one more line at the end of the script.

```js
    // add this height as a margin to the body, so that the menu won't cover everything up.
    $('body').css('margin-top', menuheight + 10)

    // below this comment is the new line
    $('#LinkList2').toggleClass('widget', '');
});
```

And then it should work. Of course you could just overwrite the styles, but removing the class altogether often seems the cleaner and faster solution.

![resultat]({{ site.img_dir }}/responsive-3-level-menu.gif)