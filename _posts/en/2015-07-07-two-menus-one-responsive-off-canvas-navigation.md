---
date: 2015-07-07 07:40:04 +0200
title: Two Menus, One Responsive Off-Canvas Navigation ♦♦♦
name: ZMerON
subtitle: two menus combined into one off-canvas nav
tags: [navigation, dropdown, responsive, sass, jade, jQuery, ♦♦♦]
description: A tutorial on how to combine two menus to one in the responsive view
category: en
---
I created this menu at work, when we wanted to have two menus but just one off-canvas navigation after the collapse. The idea was to combine an off-canvas menu with a classic navbar and then merge them into one separate off-canvas navigation on the collapse.
Suprisingly, this proved to be not as easy as I initially had thought. But it was still achieved in the end, here you'll see how.
<br>
<!-- more -->
<p data-height="266" data-theme-id="7132" data-slug-hash="oXqoJR" data-default-tab="result" data-user="mynimi" class='codepen'>See the Pen <a href='http://codepen.io/mynimi/pen/oXqoJR/'>Two Menus, One responsive Off-Canvas</a> by Myri (<a href='http://codepen.io/mynimi'>@mynimi</a>) on <a href='http://codepen.io'>CodePen</a>.</p>
<script async src="//assets.codepen.io/assets/embed/ei.js"></script>

### Markup
We start with general markup. As already said in another tutorial I usually place my menus within a header so that's what I did here as well. Then we have one container for both menus and each menu in a separate container with a list inside, since this is a dropdown.
The toggle links to open the off canvas navs as well as the triangles to toggle the sub menues are going to be added via jQuery.
I wanted the main menu to be aligned on the right and the toggle button on the left. To achieve that I had my toggle in a separate ul with the class `first` and the main menu in a list with the class `second`

Markup in Jade

```slim
header
    .menu-container
        nav.off-canvas-menu 
            ul
                li
                    a(href="#") Tasum
                li
                    a(href="#") Aldpol
                    
                li.menu-item-has-children
                    a(href="#") Oughw
                    ul.sub-menu
                        li
                            a(href="#") Shyidra
                        li
                            a(href="#") Randel
                        li
                            a(href="#") Ia'usk
                    // /.sub-menu
                    
                li
                    a(href="#") Swaimim
            // /ul
        // /.off-canvas-menu
        
        nav.main-menu
            ul.second
                li
                    a(href="#") Smedgone
                li
                    a(href="#") Aotaliope
                    
                li.menu-item-has-children
                    a(href="#") Rothiope
                    ul.sub-menu
                        li
                            a(href="#") Delirious Lyric
                        li
                            a(href="#") Cleliopyte
                        li
                            a(href="#") Xioeleia
                    // /.sub-menu
                    
                li
                    a(href="#") Iorireto    
            // /ul
        // /.main-menu
    // /.menu-container
// /header
```

And the compiled HTML of that:

```html
<header>
    <div class="menu-container">
        <nav class="off-canvas-menu">
            <ul>
                <li><a href="#">Tasum</a>
                </li>
                <li><a href="#">Aldpol</a>
                </li>
                <li class="menu-item-has-children"><a href="#">Oughw</a>
                    <ul class="sub-menu">
                        <li><a href="#">Shyidra</a>
                        </li>
                        <li><a href="#">Randel</a>
                        </li>
                        <li><a href="#">Ia'usk</a>
                        </li>
                    </ul>
                    <!-- /.sub-menu-->
                </li>
                <li><a href="#">Swaimim</a>
                </li>
            </ul>
            <!-- /ul-->
        </nav>
        <!-- /.off-canvas-menu-->
        <nav class="main-menu">
            <ul class="second">
                <li><a href="#">Smedgone</a>
                </li>
                <li><a href="#">Aotaliope</a>
                </li>
                <li class="menu-item-has-children"><a href="#">Rothiope</a>
                    <ul class="sub-menu">
                        <li><a href="#">Delirious Lyric</a>
                        </li>
                        <li><a href="#">Cleliopyte</a>
                        </li>
                        <li><a href="#">Xioeleia</a>
                        </li>
                    </ul>
                    <!-- /.sub-menu-->
                </li>
                <li><a href="#">Iorireto    </a>
                </li>
            </ul>
            <!-- /ul-->
        </nav>
        <!-- /.main-menu-->
    </div>
    <!-- /.menu-container-->
</header>
<!-- /header-->
```

### jQuery
We will work on toggles with jQuery. So add jQuery before you add the following script

```js
$(document).ready(function() {
    var offCanvasToggle = 'toggle-link-off-canvas',
        mainToggle = 'toggle-link',
        close = 'toggle-link-close';

    // add toggle links 
    $('header').prepend('<span class="toggle ' + mainToggle + '">Menu</span>');
    $('.menu-container').prepend('<span class="toggle ' + mainToggle + ' ' + close + '">close</span>');
    $('.off-canvas-menu').prepend('<span class="toggle ' + offCanvasToggle + ' ' + close + '">close</span>');
    $('.main-menu').prepend('<ul class="first"><li><span class="toggle ' + offCanvasToggle + '">Menu Off-Canvas</span></li></ul>');

    // click functions for toggle links to toggle active classes on off-canvas
    $('header .toggle-link').click(function() {
        $('.menu-container').toggleClass('active');
    });

    $('header .toggle-link-off-canvas').click(function() {
        $('.off-canvas-menu').toggleClass('active');
    });

    // add Element for caret to toggle sub-menus
    $('.menu-item-has-children > a').wrap('<span class="parent"></span>');
    $('.menu-container .parent').append('<span class="submenu-opener">open submenu</span>');

    // toggling submenus
    $('.menu-container .submenu-opener').click(function() {
        $(this).toggleClass('sub-menu-is-open');
        $(this).parent().next('.sub-menu').slideToggle();
    });
});
```

As soon as that's done, we can add the styles.

### Styling
As always I will use Sass. I use variables for the settings so feel free to play around.

Comments will go a little more into detail what everything does

```scss
// SETTINGS
//-----------

// helper
//--------

// colors
$pink: #E9B4B3;
$pale-pink: #F2E4E1;
$coal: #1D2426;
$teal: #35565D;
$grass: #8AB283;

// shortcuts
$noborder: 0 solid transparent;

// variable definitions
//----------------------
$menu-collapse: 610px;
$a_color: $pale-pink;
$a_color_hover: $pink;
$header_bg: $grass;
$off-canvas_bg: $teal;
$main_menu_bg: $coal;


// FUNCTIONS
//-----------

// squareroot
@function sqrt($r) {
    $x0: 1;
    $x1: $x0;
    @for $i from 1 through 10 {
        $x1: $x0 - ($x0 * $x0 - abs($r)) / (2 * $x0);
        $x0: $x1;
    }
    @return $x1;
}

// MIXINS
//--------

// equilateral triangle
@mixin triangle_eqla($sl, $dir, $c) {
    width: 0;
    height: 0;
    border-style: solid;
    
    @if $dir == right {
        border-color: transparent transparent transparent $c;
    }
    @if $dir == left {
        border-color: transparent $c transparent transparent;
    }
    @if $dir == bottom or $dir == down {
        border-color: $c transparent transparent transparent;
    }
    @if $dir == top or $dir == up {
        border-color: transparent transparent $c transparent;
    }
    @if $dir == right or $dir == left {
        border-width: ($sl/2) (sqrt(3)*($sl/2));
    }
    @if $dir == top or $dir == down or $dir == bottom or $dir == up {
        border-width: (sqrt(3)*($sl/2)) ($sl/2);
    }
}

// flexbox
@mixin flexbox($direction, $wrap, $justify, $align) {
    display: flex;
    flex-direction: $direction;
    flex-wrap: $wrap;
    justify-content: $justify;
    align-items: $align;
}

// STYLING
//---------

// basic styles
body {
    font: {
        size: 16px;
        weight: 400;
        family: Roboto;
    }
    line-height: 1.5;
}

a {
    color: $a_color;
    text-decoration: none;
    &:hover {
        color: $a_color_hover;
        cursor: pointer;
    }
}

// main style
header {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    background: $header_bg;
    line-height: 2;
    
    @media screen and (max-width: $menu-collapse){
        @include flexbox(row, wrap, center, center);
    }
        
    // toggle link styling
    .toggle {
        @extend a;
        padding: 6px;
    }
    
    .toggle-link-close {
        position: absolute;
        top: 0;
        right: 0;
    }
    
    .toggle-link {
        @media screen and (min-width: $menu-collapse + 1) {
            display: none;
        }
    }
    
    .toggle-link-off-canvas {
        @media screen and (max-width: $menu-collapse) {
            display: none;
        }
    }
}

// menu container, styles will be applied for the responsive version especially
.menu-container {
    @media screen and (max-width: $menu-collapse) {
        z-index: 100;
        position: fixed;
        top: 0;
        left: -300px;
        height: 100%;
        overflow-y: auto;
        background: $off-canvas_bg;
        width: 300px;
        box-sizing: border-box;
        transition: .3s all ease;
        transform: translate(0, 0);

        &.active {
            transform: translate(300px, 0);
        }
    }
    
    // sub menu styles, are the same as with the off-canvas styling
    .sub-menu {
        border-top: 1px solid rgba($coal, .5);
        border-bottom: 1px solid rgba($coal, .5);
        background: lighten($off-canvas_bg, 5%);
        display: none;
        
        li {
            a {
                box-sizing: border-box;
                @media screen and (max-width: $menu-collapse) {
                    padding-left: 25px;
                }
            }
        }
    }
    
    // clickable triangle to toggle sub menu visibility
    .parent {
        @include flexbox(row, wrap, flex-start, center);
        
        .submenu-opener {
            font-size: 0;
            position: relative;
            width: 20px;
            height: 20px;
            transition: .6s all ease;

            @media screen and (max-width: $menu-collapse) {
                margin-left: 20px;
            }

            @media screen and (min-width: $menu-collapse + 1) {
                margin-left: 5px;
            }
            
            &.sub-menu-is-open {
                transform: rotate(-180deg);
            }
            
            &:after {
                content: '';
                @include triangle_eqla(10px, down, $a_color);
                position: absolute;
                top: 50%;
                left: 50%;
                transform: translate(-50%, -20%);
                transition: .3s all ease;
            }
            
            &:hover {
                cursor: pointer;
            
                &:after {
                    border-color: $a_color_hover transparent transparent transparent;
                }
            }
        }
    }
}

// off-canvas navigation
.off-canvas-menu {
    line-height: 2.5;
    
    @media screen and (min-width: $menu-collapse + 1) {
        z-index: 100;
        position: fixed;
        top: 0;
        left: -300px;
        height: 100%;
        overflow-y: auto;
        background: $off-canvas_bg;
        width: 300px;
        box-sizing: border-box;
        transition: .3s all ease;
        transform: translate(0, 0);

        &.active {
            transform: translate(300px, 0);
        }        
    }
    
    a {
        padding: 0 10px;
    }
}

// main menu for responsive and full version
.main-menu {
    @media screen and (max-width: $menu-collapse) {
        border-top: 1px solid darken($off-canvas_bg, 5%);
        line-height: 2.5;

        a {
            padding: 0 10px;
        }
    }
    
    @media screen and (min-width: $menu-collapse + 1) {
        position: fixed;
        width: 100%;
        left: 0;
        right: 0;
        background: $main_menu_bg;
        @include flexbox(row, wrap, space-between, center);
       
        ul {
            @include flexbox(row, wrap, flex-start, center);
        
            li {
                padding: 10px;
            }
        }

        .sub-menu {
            top: 100%;
            position: absolute;
            background: lighten($main_menu_bg, 5%);
        }
    }    
}
```

And the compiled CSS of that:

```css
body {
  font-size: 16px;
  font-weight: 400;
  font-family: Roboto;
  line-height: 1.5;
}

a, header .toggle {
  color: #F2E4E1;
  text-decoration: none;
}
a:hover, header .toggle:hover {
  color: #E9B4B3;
  cursor: pointer;
}

header {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  background: #8AB283;
  line-height: 2;
}
@media screen and (max-width: 610px) {
  header {
    display: -webkit-box;
    display: -webkit-flex;
    display: -ms-flexbox;
    display: flex;
    -webkit-box-orient: horizontal;
    -webkit-box-direction: normal;
    -webkit-flex-direction: row;
        -ms-flex-direction: row;
            flex-direction: row;
    -webkit-flex-wrap: wrap;
        -ms-flex-wrap: wrap;
            flex-wrap: wrap;
    -webkit-box-pack: center;
    -webkit-justify-content: center;
        -ms-flex-pack: center;
            justify-content: center;
    -webkit-box-align: center;
    -webkit-align-items: center;
        -ms-flex-align: center;
            align-items: center;
  }
}
header .toggle {
  padding: 6px;
}
header .toggle-link-close {
  position: absolute;
  top: 0;
  right: 0;
}
@media screen and (min-width: 611px) {
  header .toggle-link {
    display: none;
  }
}
@media screen and (max-width: 610px) {
  header .toggle-link-off-canvas {
    display: none;
  }
}

@media screen and (max-width: 610px) {
  .menu-container {
    z-index: 100;
    position: fixed;
    top: 0;
    left: -300px;
    height: 100%;
    overflow-y: auto;
    background: #35565D;
    width: 300px;
    box-sizing: border-box;
    -webkit-transition: .3s all ease;
            transition: .3s all ease;
    -webkit-transform: translate(0, 0);
        -ms-transform: translate(0, 0);
            transform: translate(0, 0);
  }
  .menu-container.active {
    -webkit-transform: translate(300px, 0);
        -ms-transform: translate(300px, 0);
            transform: translate(300px, 0);
  }
}
.menu-container .sub-menu {
  border-top: 1px solid rgba(29, 36, 38, 0.5);
  border-bottom: 1px solid rgba(29, 36, 38, 0.5);
  background: #3e656d;
  display: none;
}
.menu-container .sub-menu li a, .menu-container .sub-menu li header .toggle, header .menu-container .sub-menu li .toggle {
  box-sizing: border-box;
}
@media screen and (max-width: 610px) {
  .menu-container .sub-menu li a, .menu-container .sub-menu li header .toggle, header .menu-container .sub-menu li .toggle {
    padding-left: 25px;
  }
}
.menu-container .parent {
  display: -webkit-box;
  display: -webkit-flex;
  display: -ms-flexbox;
  display: flex;
  -webkit-box-orient: horizontal;
  -webkit-box-direction: normal;
  -webkit-flex-direction: row;
      -ms-flex-direction: row;
          flex-direction: row;
  -webkit-flex-wrap: wrap;
      -ms-flex-wrap: wrap;
          flex-wrap: wrap;
  -webkit-box-pack: start;
  -webkit-justify-content: flex-start;
      -ms-flex-pack: start;
          justify-content: flex-start;
  -webkit-box-align: center;
  -webkit-align-items: center;
      -ms-flex-align: center;
          align-items: center;
}
.menu-container .parent .submenu-opener {
  font-size: 0;
  position: relative;
  width: 20px;
  height: 20px;
  -webkit-transition: .6s all ease;
          transition: .6s all ease;
}
@media screen and (max-width: 610px) {
  .menu-container .parent .submenu-opener {
    margin-left: 20px;
  }
}
@media screen and (min-width: 611px) {
  .menu-container .parent .submenu-opener {
    margin-left: 5px;
  }
}
.menu-container .parent .submenu-opener.sub-menu-is-open {
  -webkit-transform: rotate(-180deg);
      -ms-transform: rotate(-180deg);
          transform: rotate(-180deg);
}
.menu-container .parent .submenu-opener:after {
  content: '';
  width: 0;
  height: 0;
  border-style: solid;
  border-color: #F2E4E1 transparent transparent transparent;
  border-width: 8.66025px 5px;
  position: absolute;
  top: 50%;
  left: 50%;
  -webkit-transform: translate(-50%, -20%);
      -ms-transform: translate(-50%, -20%);
          transform: translate(-50%, -20%);
  -webkit-transition: .3s all ease;
          transition: .3s all ease;
}
.menu-container .parent .submenu-opener:hover {
  cursor: pointer;
}
.menu-container .parent .submenu-opener:hover:after {
  border-color: #E9B4B3 transparent transparent transparent;
}

.off-canvas-menu {
  line-height: 2.5;
}
@media screen and (min-width: 611px) {
  .off-canvas-menu {
    z-index: 100;
    position: fixed;
    top: 0;
    left: -300px;
    height: 100%;
    overflow-y: auto;
    background: #35565D;
    width: 300px;
    box-sizing: border-box;
    -webkit-transition: .3s all ease;
            transition: .3s all ease;
    -webkit-transform: translate(0, 0);
        -ms-transform: translate(0, 0);
            transform: translate(0, 0);
  }
  .off-canvas-menu.active {
    -webkit-transform: translate(300px, 0);
        -ms-transform: translate(300px, 0);
            transform: translate(300px, 0);
  }
}
.off-canvas-menu a, .off-canvas-menu header .toggle, header .off-canvas-menu .toggle {
  padding: 0 10px;
}

@media screen and (max-width: 610px) {
  .main-menu {
    border-top: 1px solid #2c474d;
    line-height: 2.5;
  }
  .main-menu a, .main-menu header .toggle, header .main-menu .toggle {
    padding: 0 10px;
  }
}
@media screen and (min-width: 611px) {
  .main-menu {
    position: fixed;
    width: 100%;
    left: 0;
    right: 0;
    background: #1D2426;
    display: -webkit-box;
    display: -webkit-flex;
    display: -ms-flexbox;
    display: flex;
    -webkit-box-orient: horizontal;
    -webkit-box-direction: normal;
    -webkit-flex-direction: row;
        -ms-flex-direction: row;
            flex-direction: row;
    -webkit-flex-wrap: wrap;
        -ms-flex-wrap: wrap;
            flex-wrap: wrap;
    -webkit-box-pack: justify;
    -webkit-justify-content: space-between;
        -ms-flex-pack: justify;
            justify-content: space-between;
    -webkit-box-align: center;
    -webkit-align-items: center;
        -ms-flex-align: center;
            align-items: center;
  }
  .main-menu ul {
    display: -webkit-box;
    display: -webkit-flex;
    display: -ms-flexbox;
    display: flex;
    -webkit-box-orient: horizontal;
    -webkit-box-direction: normal;
    -webkit-flex-direction: row;
        -ms-flex-direction: row;
            flex-direction: row;
    -webkit-flex-wrap: wrap;
        -ms-flex-wrap: wrap;
            flex-wrap: wrap;
    -webkit-box-pack: start;
    -webkit-justify-content: flex-start;
        -ms-flex-pack: start;
            justify-content: flex-start;
    -webkit-box-align: center;
    -webkit-align-items: center;
        -ms-flex-align: center;
            align-items: center;
  }
  .main-menu ul li {
    padding: 10px;
  }
  .main-menu .sub-menu {
    top: 100%;
    position: absolute;
    background: #283234;
  }
}
```

And that's it.