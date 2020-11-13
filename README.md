# NAME

HTML::SimpleLinkExtor - Extract links from HTML

# SYNOPSIS

        use HTML::SimpleLinkExtor;

        my $extor = HTML::SimpleLinkExtor->new();
        $extor->parse_file($filename);
        #--or--
        $extor->parse($html);

        $extor->parse_file($other_file); # get more links

        $extor->clear_links; # reset the link list

        #extract all of the links
        @all_links   = $extor->links;

        #extract the img links
        @img_srcs    = $extor->img;

        #extract the frame links
        @frame_srcs  = $extor->frame;

        #extract the hrefs
        @area_hrefs  = $extor->area;
        @a_hrefs     = $extor->a;
        @base_hrefs  = $extor->base;
        @hrefs       = $extor->href;

        #extract the body background link
        @body_bg     = $extor->body;
        @background  = $extor->background;

        @links       = $extor->schemes( 'http' );

# DESCRIPTION

This is a simple HTML link extractor designed for the person who does
not want to deal with the intricacies of `HTML::Parser` or the
de-referencing needed to get links out of `HTML::LinkExtor`.

You can extract all the links or some of the links (based on the HTML
tag name or attribute name). If a `<BASE HREF>` tag is found,
all of the relative URLs will be resolved according to that reference.

This module is simply a subclass around `HTML::LinkExtor`, so it can
only parse what that module can handle.  Invalid HTML or XHTML may
cause problems.

If you parse multiple files, the link list grows and contains the
aggregate list of links for all of the files parsed. If you want to
reset the link list between files, use the clear\_links method.

## Class Methods

- $extor = HTML::SimpleLinkExtor->new()

    Create the link extractor object.

- $extor = HTML::SimpleLinkExtor->new('')
- $extor = HTML::SimpleLinkExtor->new($base)

    Create the link extractor object and resolve the relative URLs
    accoridng to the supplied base URL. The supplied base URL overrides
    any other base URL found in the HTML.

    Create the link extractor object and do not resolve relative
    links.

- HTML::SimpleLinkExtor->ua;

    Returns the internal user agent, an `LWP::UserAgent` object.

- HTML::SimpleLinkExtor->add\_tags( TAG \[, TAG \] )

    `HTML::SimpleLinkExtor` keeps an internal list of HTML tags (such as
    'a' and 'img') that have URLs as values. If you run into another tag
    that this module doesn't handle, please send it to me and I'll add it.
    Until then you can add that tag to the internal list. This affects
    the entire class, including previously created objects.

- HTML::SimpleLinkExtor->add\_attributes( ATTR \[, ATTR\] )

    `HTML::SimpleLinkExtor` keeps an internal list of HTML tag attributes
    (such as 'href' and 'src') that have URLs as values. If you run into
    another attribute that this module doesn't handle, please send it to
    me and I'll add it. Until then you can add that attribute to the
    internal list. This affects the entire class, including previously
    created objects.

- can()

    A smarter `can` that can tell which attributes are also methods.

- HTML::SimpleLinkExtor->remove\_tags( TAG \[, TAG \] )

    Take tags out of the internal list that `HTML::SimpleLinkExtor` uses
    to extract URLs. This affects the entire class, including previously
    created objects.

- HTML::SimpleLinkExtor->remove\_attributes( ATTR \[, ATTR\] )

    Takes attributes out of the internal list that
    `HTML::SimpleLinkExtor` uses to extract URLs. This affects the entire
    class, including previously created objects.

- HTML::SimpleLinkExtor->attribute\_list

    Returns a list of the attributes `HTML::SimpleLinkExtor` pays
    attention to.

- HTML::SimpleLinkExtor->tag\_list

    Returns a list of the tags `HTML::SimpleLinkExtor` pays attention to.
    These tags have convenience methods.

## Object methods

- $extor->parse\_file( $filename )

    Parse the file for links. Inherited from `HTML::Parser`.

- $extor->parse\_url( $url \[, $ua\] )

    Fetch URL and parse its content for links.

- $extor->parse( $data )

    Parse the HTML in `$data`. Inherited from `HTML::Parser`.

- $extor->clear\_links

    Clear the link list. This way, you can use the same parser for
    another file.

- $extor->links

    Return a list of the links.

- $extor->img

    Return a list of the links from all the SRC attributes of the
    IMG.

- $extor->frame

    Return a list of all the links from all the SRC attributes of
    the FRAME.

- $extor->iframe

    Return a list of all the links from all the SRC attributes of
    the IFRAME.

- $extor->frames

    Returns the combined list from frame and iframe.

- $extor->src

    Return a list of the links from all the SRC attributes of any
    tag.

- $extor->a

    Return a list of the links from all the HREF attributes of the
    A tags.

- $extor->area

    Return a list of the links from all the HREF attributes of the
    AREA tags.

- $extor->base

    Return a list of the links from all the HREF attributes of the
    BASE tags.  There should only be one.

- $extor->href

    Return a list of the links from all the HREF attributes of any
    tag.

- $extor->body, $extor->background

    Return the link from the BODY tag's BACKGROUND attribute.

- $extor->script

    Return the link from the SCRIPT tag's SRC attribute

- $extor->schemes( SCHEME, \[ SCHEME, ... \] )

    Return the links that use any of SCHEME. These must be absolute URLs (which
    might include those converted to absolute URLs by specifying a
    base). SCHEME is case-insensitive. You can specify more than one
    scheme.

    In list context it returns the links. In scalar context it returns
    the count of the matching links.

- $extor->absolute\_links

    Returns the absolute URLs (which might include those converted to
    absolute URLs by specifying a base).

    In list context it returns the links. In scalar context it returns
    the count of the matching links.

- $extor->relative\_links

    Returns the relatives URLs (which might exclude those converted to
    absolute URLs by specifying a base or having a base in the document).

    In list context it returns the links. In scalar context it returns
    the count of the matching links.

# TO DO

This module doesn't handle all of the HTML tags that might
have links.  If someone wants those, I'll add them, or you
can edit `%AUTO_METHODS` in the source.

# CREDITS

Will Crain who identified a problem with IMG links that had
a USEMAP attribute.

# AUTHORS

brian d foy, `<bdfoy@cpan.org>`

Maintained by Nigel Horne, `<njh at bandsman.co.uk>`

# COPYRIGHT AND LICENSE

Copyright © 2004-2019, brian d foy <bdfoy@cpan.org>. All rights reserved.

This program is free software; you can redistribute it and/or modify
it under the terms of the Artistic License 2.0.
