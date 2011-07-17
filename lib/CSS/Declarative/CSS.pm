package CSS::Declarative::CSS;

use warnings;
use strict;

#use base qw(CSS::Declarative::Element);  # Unlike HTML, our root node is not an element.  When iterating, it just iterates its children with no
#                                         # "tags" of its own.
use base qw(Decl::Node);

use Iterator::Simple qw(:all);

our $ACCEPT_EVENTS = 1;


=head1 NAME

CSS::Declarative::CSS - implements the root node for a CSS ruleset.  (Could be a single class, or multiple ones.)

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';


=head1 SYNOPSIS



=head1 INTERNALS

=head2 defines()

Called by C<Decl> during import, to find out what xmlapi tags this plugin claims to implement.

=cut
sub defines { ('css', 'class'); }
sub tags_defined { Decl->new_data(<<EOF); }
css   (vanilla=CSS::Declarative::Element)
class (vanilla=CSS::Declarative::Element)
EOF

=head2 iterate

Iteration of the main CSS object is just the iteration of its body: either it's a text/code thing (in which case it will just print to output)
or we iterate its children.

=cut

sub iterate {
   my ($self) = @_;
   
   return Decl::Node::iterate($self) if $self->code or $self->bracket;
   
   my $deref = $self->deref;
   my $list = [];
   my @content;
   @content = $deref->nodes if defined $deref;   # TODO: Make this whole thing lazier.  NOTE for CSS: not content_nodes, just nodes (can haz :)
   if (@content) {
      #my $child_iterators = ichain map {$_->iterate()} @content;
      #$list = imap { chomp $_; "   $_\n" } $child_iterators;
      $list = ichain map {$_->iterate()} @content;
   } else {
      $list = imap { chomp $_; "   $_\n" } Decl::Node::iterate($self);
   }
   $list;
}


=head1 AUTHOR

Michael Roberts, C<< <michael at vivtek.com> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-css-declarative at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=CSS-Declarative>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.

=head1 LICENSE AND COPYRIGHT

Copyright 2011 Michael Roberts.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.

=cut

1; # End of CSS::Declarative::CSS
