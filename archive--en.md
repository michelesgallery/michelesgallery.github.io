---
group: "navigation-04"
title: Archive
lang: en
id: archive
permalink: /en/archive/
description: All posts by ½ a px. Posts about blogger, jekyll, HTML Sass and other things web-related.
---
{% if site.baseurl != '' or null %}
    {% assign base = site.baseurl %}
{% else %}
    {% assign base = '' %}
{% endif %}

{% assign posts = site.posts | where:"lang", page.lang %}
Date | Title | Tags
---|---|---
{% for post in posts%}{% include date.md %} | [{{ post.title }}]({{ post.url | prepend: base }}) | {% for tag in post.tags %} <a href="{{ site.tag_dir | prepend: base }}/{{ tag }}" class="tag">{{ tag }}</a> {% endfor %}
{% endfor %}