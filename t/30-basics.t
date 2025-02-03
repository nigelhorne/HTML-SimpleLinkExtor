#!/usr/bin/env perl

use Test::Most;
use HTML::SimpleLinkExtor;

my $html = '<a href="https://example.com">Example</a>
            <img src="image.jpg">
            <iframe src="https://example.net"></iframe>';

# Ensure the module loads
use_ok('HTML::SimpleLinkExtor');

# Create an instance
my $extor = HTML::SimpleLinkExtor->new();
isa_ok($extor, 'HTML::SimpleLinkExtor', 'Object created successfully');

# Parse HTML
$extor->parse($html);

# Extract links
my @all_links = $extor->links();
my @href_links = $extor->a();
my @img_links = $extor->img();
my @iframe_links = $extor->iframe();

# Validate extracted links
is_deeply(\@href_links, ['https://example.com'], 'Extracted correct href link');
is_deeply(\@img_links, ['image.jpg'], 'Extracted correct img src');
is_deeply(\@iframe_links, ['https://example.net'], 'Extracted correct iframe src');

# Test absolute vs. relative links
is(scalar($extor->absolute_links()), 2, 'Correct number of absolute links');
is(scalar($extor->relative_links()), 1, 'Correct number of relative links');

done_testing();
