/* global $:false, document:false, window:false, setInterval: false */

$(document).ready(function () {
    'use strict';
    
    // open external links in new window
    $("a[href^='http']").attr("target", "_blank");

    $(window).resize(function () {
        // Variables
        var didScroll,
            lastScrollTop = 0,
            delta = 15,
            navbarHeight = $('nav').outerHeight(),
            headerHeight = $('.header').outerHeight();
          
        // Instantiate MixItUp:
        $('#container').mixItUp();

        $('.backtotop').click(function () {
            $('body,html').animate({
                scrollTop: 0
            }, 500);
        });

        // responsive Menu
        $('.menu .toggle').click(function () {
            $('.responsive').toggleClass('active');
        });

        // add margin top for fixed nav
        $('body').css({
            'margin-top': navbarHeight
        });

        // dissapearing .header based on nav state
        /* $(window).scroll(function (event) {
            if ($(window).scrollTop() > (headerHeight + navbarHeight)) {
                didScroll = true;
            }
        }); */

        function hasScrolled() {
            var st = $(window).scrollTop();

            if (Math.abs(lastScrollTop - st) <= delta) {
                return;
            }

            if (st > lastScrollTop && st > navbarHeight) {
                // Scroll Down
                $('nav').css({top: -navbarHeight});
            } else {
                // Scroll Up
                if (st + $(window).height() < $(document).height()) {
                    $('nav').css({top: '0'});
                }
            }
            lastScrollTop = st;
        }

        setInterval(function () {
            if (didScroll) {
                hasScrolled();
                didScroll = false;
            }
        }, 250);

        // make it so, that content fills at least whole window
        $('.wrapper').css({
            'min-height': $(window).height() - $('.header').outerHeight() - $('footer').height() - $('.menu').height() // because 13 is the magic number
        });


    }).resize(); // trigger resize handlers
});

// lightbox
// lightbox stuff
$(function () {
    var activityIndicatorOn = function () {
            $('<div id="imagelightbox-loading"><div></div></div>').appendTo('body');
        },
        activityIndicatorOff = function () {
            $('#imagelightbox-loading').remove();
        },

        // OVERLAY
        overlayOn = function () {
            $('<div id="imagelightbox-overlay"></div>').appendTo('body');
        },
        overlayOff = function () {
            $('#imagelightbox-overlay').remove();
        },

        // CLOSE BUTTON
        closeButtonOn = function (instance) {
            $('<button type="button" id="imagelightbox-close" title="Close"><i class="fa fa-times-circle"></i></button>').appendTo('body').on('click touchend', function () {
                $(this).remove();
                instance.quitImageLightbox();
                return false;
            });
        },
        closeButtonOff = function () {
            $('#imagelightbox-close').remove();
        },

        // CAPTION
        captionOn = function () {
            var description = $('a[href="' + $('#imagelightbox').attr('src') + '"] img').attr('alt');
            if (description.length > 0)
                $('<div id="imagelightbox-caption">' + description + '</div>').appendTo('body');
        },
        captionOff = function () {
            $('#imagelightbox-caption').remove();
        },

        // NAVIGATION
        navigationOn = function (instance, selector) {
            var images = $(selector);
            if (images.length) {
                var nav = $('<div id="imagelightbox-nav"></div>');
                for (var i = 0; i < images.length; i++)
                    nav.append('<button type="button"></button>');
                nav.appendTo('body');
                nav.on('click touchend', function () {
                    return false;
                });
                var navItems = nav.find('button');
                navItems.on('click touchend', function () {
                        var $this = $(this);
                        if (images.eq($this.index()).attr('href') != $('#imagelightbox').attr('src'))
                            instance.switchImageLightbox($this.index());
                        navItems.removeClass('active');
                        navItems.eq($this.index()).addClass('active');
                        return false;
                    })
                    .on('touchend', function () {
                        return false;
                    });
            }
        },
        navigationUpdate = function (selector) {
            var items = $('#imagelightbox-nav button');
            items.removeClass('active');
            items.eq($(selector).filter('[href="' + $('#imagelightbox').attr('src') + '"]').index(selector)).addClass('active');
        },
        navigationOff = function () {
            $('#imagelightbox-nav').remove();
        },

        // ARROWS
        arrowsOn = function (instance, selector) {
            var $arrows = $('<button type="button" class="imagelightbox-arrow imagelightbox-arrow-left"></button><button type="button" class="imagelightbox-arrow imagelightbox-arrow-right"></button>');
            $arrows.appendTo('body');
            $arrows.on('click touchend', function (e) {
                e.preventDefault();
                var $this = $(this),
                    $target = $(selector + '[href="' + $('#imagelightbox').attr('src') + '"]'),
                    index = $target.index(selector);

                if ($this.hasClass('imagelightbox-arrow-left')) {
                    index = index - 1;
                    if (!$(selector).eq(index).length)
                        index = $(selector).length;
                } else {
                    index = index + 1;
                    if (!$(selector).eq(index).length)
                        index = 0;
                }
                instance.switchImageLightbox(index);
                return false;
            });
        },
        arrowsOff = function () {
            $('.imagelightbox-arrow').remove();
        };

    //	ALL COMBINED
    var selectorF = 'a[data-imagelightbox="f"]';
    var instanceF = $(selectorF).imageLightbox({
        onStart: function () {
            overlayOn();
            closeButtonOn(instanceF);
            arrowsOn(instanceF, selectorF);
        },
        onEnd: function () {
            overlayOff();
            captionOff();
            closeButtonOff();
            arrowsOff();
            activityIndicatorOff();
        },
        onLoadStart: function () {
            captionOff();
            activityIndicatorOn();
        },
        onLoadEnd: function () {
            captionOn();
            activityIndicatorOff();
            $('.imagelightbox-arrow').css('display', 'block');
        }
    });
});