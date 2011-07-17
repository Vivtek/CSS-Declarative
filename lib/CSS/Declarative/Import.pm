package CSS::Declarative::Import;

use warnings;
use strict;

use base qw(Decl::Node);

use Iterator::Simple qw(:all);

our $ACCEPT_EVENTS = 1;


=head1 NAME

CSS::Declarative::Import - implements an import directive in a CSS tree.

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';


=head1 SYNOPSIS

The import directive is parsed vanilla.  We ignore any children; only the label and the name make any difference.

=head1 INTERNALS

=head2 defines()

Called by C<Decl> during import, to find out what xmlapi tags this plugin claims to implement.

=cut
sub defines { (); }
sub tags_defined { Decl->new_data(<<EOF); }
import
EOF


=head2 iterate

The contents of the comment tag, if parsed, can be written out as commented-out CSS.  Just ... in case you feel the
need to do that, I guess.

=cut

sub iterate {
   my ($self) = @_;
   
   return iter(['@import "' . $self->label . '";']) if $self->label;
   # TODO: Find the actual file referred to and use its filename.  I'm too bored to do this right, so instead I'm cheating here.
   return iter(['@import "' . $self->name . '.css";']);
   # TODO: Five bucks says I spend two hours finding this in eight months, and curse my July self.
}



=head1 AUTHOR

Michael Roberts, C<< <michael at vivtek.com> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-html-declarative at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=CSS-Declarative>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.

=head1 LICENSE AND COPYRIGHT

Copyright 2010 Michael Roberts.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.

=cut

1; # End of CSS::Declarative::Import
