package CSS::Declarative::Element;

use warnings;
use strict;

use base qw(Decl::Node);

use Iterator::Simple qw(:all);

our $ACCEPT_EVENTS = 1;


=head1 NAME

CSS::Declarative::Element - implements a generic element in a CSS tree.  More specialized tags inherit from Element.

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
#sub tags_defined { Decl->new_data(<<EOF); }
#css (vanilla=CSS::Declarative::Element)
#EOF

=head1 SWITCHING CLASSES

Since we parse in vanilla mode, all elements within a CSS tag are considered to be CSS elements.  By default, an element
is just a value.  However, there are a few keywords that denote something other than values: C<rule>, especially.

All CSS parses with a special parser - this permits the use of the # character in CSS for things other than comments.
Since I want to preserve the naming rules, this is essential.

=head2 preprocess()

The subclassing here is just the same as the trick I used for HTML::Declarative.  It's weird but it works.

=cut

our %special_tags = (
   rule     => 'CSS::Declarative::Rule',
   comment  => 'CSS::Declarative::Comment',
   import   => 'CSS::Declarative::Import',
);

sub preprocess_line() {
   my ($self) = @_;
   $self->{vanilla_class} = 'CSS::Declarative::Element';  # TODO: kind of a hack, but the reblessing seems to screw
                                                          #       with the vanilla class propagation.  Look into this.
                                                           
   my $special_class = $special_tags{$self->tag};
   bless $self, $special_class if defined $special_class;
}

=head2 decode_line

First time I've overridden this, too.  TODO: make it less lame.

=cut

sub decode_line {
   my ($self) = @_;
   my $l;
   ($l, $self->{comment}) = split /\s+#\s+/, $self->line, 2;
   $l = '' unless defined $l;
   $l =~ s/;$//;
   $self->{label} = $l;
}

=head2 iterate

The generic CSS element is simply a value.  It has no children.

=cut

sub iterate {
   my ($self) = @_;
   
   return Decl::Node::iterate($self) if $self->code or $self->bracket;
   if (not defined $self->label) {
      print "label not defined for $self\n";
      print $self->describe . "\n";
   }
   iter ([$self->tag . ': ' . $self->label . ';']);
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

1; # End of CSS::Declarative::Element
