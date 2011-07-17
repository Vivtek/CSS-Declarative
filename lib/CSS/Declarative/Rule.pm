package CSS::Declarative::Rule;

use warnings;
use strict;

use base qw(Decl::Node);

use Iterator::Simple qw(:all);

our $ACCEPT_EVENTS = 1;


=head1 NAME

CSS::Declarative::Rule - implements a CSS rule.  Knows how to nest inside other rules for a kind of OO structure.

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';


=head1 SYNOPSIS

A CSS rule has a selector and a body in curly braces.  In Decl, the selector is simply the entire line, and the indentation of the children
denote the body.  Simple as that.  Since Decl CSS rules can nest, the final selector is made up of a concatenation of the parent's selector
with the current rule's.

Each selector name is also saved and can be referenced elsewhere in the enclosing node for brevity's sake.  You can also use the "set" tag
to do that save assignment without a rule being output.

=head1 INTERNALS

=head2 defines()

Called by C<Decl> during import, to find out what xmlapi tags this plugin claims to implement.

=cut
sub defines { ('rule'); }
sub tags_defined { Decl->new_data(<<EOF); }
rule (vanilla=CSS::Declarative::Rule)
EOF

=head1 SWITCHING CLASSES

=head2 decode_line

First time I've overridden this, too.  TODO: make it less lame.

=cut

sub decode_line {
   my ($self) = @_;
   my $l;
   ($l, $self->{comment}) = split /\s+#\s+/, $self->line, 2;
   my @names = split /\s*,\s*/, $l;
   $self->{namelist} = \@names;
   $self->{name} = $names[0];
   
   my @classes = ();
   my @parent_classes = ();
   @parent_classes = @{$self->parent->{classlist}} if $self->parent and $self->parent->{classlist};
   foreach my $name (@names) {
      if (@parent_classes) {
         foreach my $class (@parent_classes) {
            if ($name =~ /^:/) {
               push @classes, "$class$name";
            } else {
               push @classes, "$class $name";
            }
         }
      } else {
         push @classes, $name;
      }
   }
      
   $self->{classlist} = \@classes;
}

=head2 iterate

The rule contains values.  It therefore iterates along them.

=cut

sub iterate {
   my ($self) = @_;
   
   return Decl::Node::iterate($self) if $self->code or $self->bracket;
   
   my $deref = $self->deref;
   my $list = [];
   my @content;
   @content = $deref->nodes if defined $deref;   # TODO: Make this whole thing lazier.
   
   my @values = ();
   my @subrules = ();
   foreach my $c (@content) {
      if ($c->is('rule')) {
         push @subrules, $c;
      } else {
         push @values, $c;
      }
   }
   if (@values) {
      my $child_iterators = ichain map {$_->iterate} @values;
      $list = imap { chomp $_; "   $_\n" } $child_iterators;
      $list = ichain (
         iter ([join (', ', @{$self->{classlist}}) . ' {']),
         $list,
         iter (['}']),
      );
   }
   if (@subrules) {
      $list = ichain (
         $list,
         map {$_->iterate} @subrules,
      );
   }
   $list;
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

1; # End of CSS::Declarative::Rule
