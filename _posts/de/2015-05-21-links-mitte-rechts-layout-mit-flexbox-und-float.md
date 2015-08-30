---
title: Links-Mitte-Rechts-Layout mit Flexbox und Float ♦♦
subtitle: Zentrieren ist gar nicht so einfach...
description: Ein Quicktip, wie man ein Dreier-Layout einfach umsetzt
tags: [tutorial, quicktip, sass, css, html, flexbox, ♦♦ ]
name: lmr-layout
---
### Das Problem.
Ich bin ein grosser Grid-Fan. Ein "links-mitte-rechts"-Layout ist in meinem täglichen Gebrauch keine Seltenheit. Allerdings hatte ich es bisher meist nur mit gleich breiten Komponenten zu tun. Als ich allerdings letztesn mit drei Buttons das Layout umsetzen wollte, habe ich festgestellt, dass es gar nicht so einfach ist, wie gedacht.

Wie ihr es aber dennoch schnell beheben könnt, möchte ich euch hier zeigen.

<br><!-- more -->
<p data-height="409" data-theme-id="7132" data-slug-hash="WvGdZL" data-default-tab="result" data-user="mynimi" class='codepen'>See the Pen <a href='http://codepen.io/mynimi/pen/WvGdZL/'>WvGdZL</a> by Myri (<a href='http://codepen.io/mynimi'>@mynimi</a>) on <a href='http://codepen.io'>CodePen</a>.</p>
<script async src="//assets.codepen.io/assets/embed/ei.js"></script>
<br>

Wie ihr oben im Beispiel sehen könnt, wird das Problem schnell klar. Die Beispiele Float1 und Flex1 sind so geschrieben, wie ich es für gewöhnlich tun würde, mit kurzem Markup und kurzen Style-Angaben. Wenn wir aber eines der beiden Worte deutlich länger machen, wird klar was genau gemacht wird.

Bevor das Center-Element zentriert wird, werden die beiden äusseren Breiten reduziert.

In Flexbox heisst das `space-between` also Platz dazwischen. Der Zwischenraum ist überall gleich gross. Das mag in gewissen fällen sehr praktisch sein, doch bei diesem Layout ist Beispiel 2 erstrebenswerter.

### Aufbau
okay, wie bauen wir das auf? Für Version 1 brauchen wir jeweils ein simples HTML-Markup. Einmal container und darin drei Elemente.

```html
<div class="row"> <!-- hier füge ich jeweils noch entweder Klasse "float-1" oder "flex-1" hinzu -->
    <div class="left">left</div>
    <div class="center">center</div>
    <div class="right">right</div>
</div>
```

Gestaltet wird das dann mit CSS wie folgt (ich benutze Autoprefixer, also hier keine Prefixe) Wer das ganze in Sass sehen will, ist sehr willkommen, das beim CodePen zu tun.

Grundsätzlich gestalten wir den Container.

```css
/* Grundstyle */
.row {
  position: relative;
  margin: 0 auto;
  width: 80%;
  max-width: 1400px;
}
```

Dann zur Float-Variante, die wohl die meisten Leute anwenden würden.

```css
/* für die Zentrierung */
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


Alternative in Flexbox ist viel kürzer und deswegen die Variante, die ich stets verwende. Mit einem Sass-Mixin reduziert sich dieser Schritt auf eine einzige Zeile.

```css
.flex-1 {
  display: flex;
  flex-direction: row;
  flex-wrap: wrap;
  justify-content: space-between;
  align-items: center;
}
```

Wenn ihr die beiden Beispiele zuerst anseht, könnt ihr erkennen, dass er Unterschied bei relativ gleich grossen Elementen minimal ist. Die Mitte des zentierten Textes liegt fast auf der gezeichneten Y-Achse.
Aber verlängern wir nur eines der Worte, bringen den Text also aus dem Gleichgewicht, bricht unser Konstrukt zusammen. Um es zu stabilisieren, gibt es einen Grundgedanken:

### Die Lösung.

Die Idee ist es, gleich grosse Container zu generieren. Wenn alle Elemente gleich gross sind, kann innerhalb davon entsprechend generiert werden. Das innere Markup musste ich dafür etwas anspassen, indem ich die Elemente, noch in eigene container gepackt habe.

```html
<span class="left"><span>left</span></span>
<span class="center"><span>center</span></span>
<span class="right"><span>right</span></span>
```

Umgesetzt in CSS wird das dann so:

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

/* gemeinsame Breite (100% / 3) */
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

/* Textausrichtung */
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

/* flex: 1 bedeutet, dass jedes der Elemente gleich viel Platz bekommen soll. */
.flex-2 span {
  flex: 1;
}

/* Textausrichtung */
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

Und das ist auch schon alles. Und schon haben wir eine korrekte Zentrierung.