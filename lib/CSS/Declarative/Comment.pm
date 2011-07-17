package CSS::Declarative::Comment;

use warnings;
use strict;

use base qw(Decl::Node);

use Iterator::Simple qw(:all);

our $ACCEPT_EVENTS = 1;


=head1 NAME

CSS::Declarative::Comment - implements a comment in an CSS tree, should you need the comment to be written to the CSS.

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';


=head1 SYNOPSIS



=head1 INTERNALS

=head2 defines()

Called by C<Decl> during import, to find out what xmlapi tags this plugin claims to implement.

=cut
sub defines { (); }
sub tags_defined { Decl->new_data(<<EOF); }
comment (body=text)
EOF

=head2 preprocess

During preprocess, the class can set up things for the parse step.  Here, we use it to force text-only parsing (i.e. no parsing) because
our late-triggering class reassignment misses the text-only marker on the tag definition.

TODO: There's probably a better way to organize this.

=cut

sub preprocess { $_[0]->{force_text} = 1; }


=head2 iterate

The contents of the comment tag, if parsed, can be written out as commented-out CSS.  Just ... in case you feel the
need to do that, I guess.

=cut

sub iterate {
   my ($self) = @_;
   
   return Decl::Node::iterate($self) if $self->code or $self->bracket;
   
   return iter(['/* ' . $self->label . ' */']) if $self->label;
   
   my @content = $self->content_nodes;   # TODO: Make this whole thing lazier.
   my $list;
   if (@content) {
      my $child_iterators = ichain map {$_->iterate} @content;
      $list = imap { chomp $_; " * $_\n" } $child_iterators;
   } else {
      $list = imap { chomp $_; " * $_\n" } Decl::Node::iterate($self);
   }
   ichain (
      iter (['/**' . "\n"]),
      $list,
      iter ([' */' . "\n"]),
   );
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

1; # End of CSS::Declarative::Comment
