---
title: Portfolio
group: navigation-03
lang: en
id: portfolio
permalink: /en/portfolio/
description: all of my themes. responsive blogger and jekyll themes for free
---
<!--<div class="filtering">
    <span class="filter" data-filter="all">show all</span> &bull;
    <span class="filter" data-filter=".jekyll">jekyll</span> &bull;
    <span class="filter" data-filter=".blogger">Blogger</span>
</div>-->

{% if site.baseurl != '' or null %}
    {% assign base = site.baseurl %}
{% else %}
    {% assign base = '' %}
{% endif %}

<div class="portfolio-wrapper" id="container">
    {% assign portfolio = site.portfolio | sort: "date" | reverse | where:"lang", page.lang %}
    {% for item in portfolio %}
        <div class="item-wrapper mix {{ item.category }}">
            {% if item.title and item.gallery %}
                <a href="{{ item.url | remove: '/index.html' | prepend: base }}">
                    {% for gallery in item.gallery %}
                        {% for image in gallery.images limit: 1%}
                            {% if image.filename contains '.png'%}
                                {% assign thumb = image.filename | replace: '.png', '' %}
                                <img src="{{ site.img_dir | prepend: base }}/{{ thumb | append: '-450x450.png' }}" alt="{{ image.alttext }}">
                            {% elsif image.filename contains '.jpg'%}
                                {% assign thumb = image.filename | replace: '.jpg', '' %}
                                <img src="{{ site.img_dir | prepend: base }}/{{ thumb | append: '-450x450.jpg' }}" alt="{{ image.alttext }}">
                            {% endif %}
                        {% endfor %}
                    {% endfor %}
                    {% if item.title %}
                        <h1>{{ item.title }}</h1>
                    {% endif %}
                    {% if item.subtitle %}
                        <h2 class="subtitle">{{ item.subtitle }}</h2>
                    {% endif %}
                        <p>{% include date.html %}</p>
                </a>
            {% endif %}
        </div>
    {% endfor %}
</div>

