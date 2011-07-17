package CSS::Declarative;

use warnings;
use strict;

use base qw(Decl::Semantics);

=head1 NAME

CSS::Declarative - A declarative approach to CSS

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';


=head1 SYNOPSIS

Since CSS itself is already declarative, CSS::Declarative really only provides a convenient way to parse it in a Decl script and extract
CSS text when the time comes.  There are some refinements, largely based on LessCSS, that allow greater structuring of CSS::Declarative code
than CSS itself supports.

By itself, L<CSS::Declarative> is not terribly useful.  It's really best used from L<WWW::Publisher>.  It does, however, contain some CSS
boilerplate components that might come in handy outside that framework.

=head1 DECL-SPECIFIC STUFF YOU DON'T CARE ABOUT

=head2 tag(), start, file_root, our_flags

These represent the machinery needed by C<Decl> to interface with the semantics of the modules we're using.
You almost certainly won't need them.
The C<start> function is called by the framework to start the application if this semantic class is the controlling class.
The C<tag> function just tells C<Decl> that we answer to the semantic domain tag of 'html'.

=cut
sub file_root { __FILE__ }
our $flags = {};
sub our_flags { $flags }
sub tag { 'css' }

=head1 UTILITY FUNCTIONS

None yet.

=head1 BOILERPLATE MACROS

Decl allows us to define macros that target any language, so it's a useful framework for the definition of boilerplate.


=head1 AUTHOR

Michael Roberts, C<< <michael at vivtek.com> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-css-declarative at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=CSS-Declarative>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.




=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc CSS::Declarative


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=CSS-Declarative>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/CSS-Declarative>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/CSS-Declarative>

=item * Search CPAN

L<http://search.cpan.org/dist/CSS-Declarative/>

=back


=head1 ACKNOWLEDGEMENTS


=head1 LICENSE AND COPYRIGHT

Copyright 2011 Michael Roberts.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.


=cut

1; # End of CSS::Declarative
