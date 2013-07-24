package Pod::POM::View::Wiki;

use warnings;
use strict;

use base qw( Pod::POM::View::Text );

=head1 NAME

Pod::POM::View::Wiki - Wiki view for Pod::POM module

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';


=head1 SYNOPSIS

For now, it is a very alpha version to initiate the project

This view allow to use Pod::POM script with wiki view like this :

pom2 wiki path_to_my_file.pod > path_to_my_file.wiki

=head1 SUBROUTINES/METHODS


# Weborama Patch public / private
sub view_public {
    my ($self, $public) = @_;
    if ($self->{public})
    {
        return $public->content->present($self);
    }
    return '';
}
# end

# Weborama Patch public / private
sub view_private {
    my ($self, $private) = @_;
    if ($self->{private})
    {
        return $private->content->present($self);
    }
}
# end
=cut

=head2 view_head1

overwrite view_head1 form Wiki

=cut
sub view_head1 {
  my ($self, $node) = @_;
  return "======= ".$node->title->present($self)." =======\n\n" . $node->content->present($self);
}

=head2 view_head2

overwrite view_head2 form Wiki

=cut
sub view_head2 {
  my ($self, $node) = @_;
  return "====== ".$node->title->present($self)." ======\n\n" . $node->content->present($self);
}

=head2 view_head3

overwrite view_head3 form Wiki

=cut
sub view_head3 {
  my ($self, $node) = @_;
  return "===== ".$node->title->present($self)." =====\n\n" . $node->content->present($self);
}

=head2 view_head4

overwrite view_head4 form Wiki

=cut
sub view_head4 {
  my ($self, $node) = @_;
  return "==== ".$node->title->present($self)." ====\n\n" . $node->content->present($self);
}

#-------------------------------------------------------------------------------
# Weborama patch
#-------------------------------------------------------------------------------
sub view_function {
    my ($self, $function) = @_;
    my $title = $function->title;
    return "==== $title ====\n\n"
	. $function->content->present($self);
}


sub view_method {
    my ($self, $method) = @_;
    return "**Method : **\n\n"
	. $method->content->present($self);
}


sub view_call {
    my ($self, $call) = @_;
    return "**Call : **\n\n"
	. $call->content->present($self);
}


sub view_response {
    my ($self, $response) = @_;
    return "**Response : **\n\n"
	. $response->content->present($self);
}

#-------------------------------------------------------------------------------
# End of Weborama patch
#-------------------------------------------------------------------------------






=head2 view_textblock

overwrite view_textblock form Wiki

=cut
#sub view_textblock {
#  my ($self, $node) = @_;
#  return "textblock";#"=== ".$node->title->present($self)." ===\n\n" . $node->content->present($self);
#}

=head2 view_seq_code

overwrite view_seq_code for wiki


sub view_seq_code{
  my ($self, $node) = @_;
  my $result = '';
  while (my $line = <$node>)
  {
    if ($line =~ /\s+(\^.*\^)$/)
    { $result = $1; }
    else
    { $result = $line;}
  }
  return "code";#$result;
}
=cut

=head2 view_verbatim

overwrite view_verbatim for wiki

=cut

sub view_verbatim{
  my ($self, $node) = @_;
  my $result = '';
  my @nodes = split /\n/, $node;
  foreach my $line (@nodes)
  {
    if ($line =~ /\s+(\^.*\^)$/)
    { $result .= $1."\n"; }
    elsif ($line =~ /\s+(\|.*\|)$/)
    { $result .= $1."\n"; }
    else
    { $result .= $line."\n";}
  }
  return "$result\n";
}

=head2 view_textblock

overwrite view_textblock for wiki

=cut

sub view_textblock {
  my ($self, $node) = @_;

  $node =~ s/\n([A-Za-z])/\\\\ $1/g;
  return "$node\n\n";
}

=head2 view_seq_bold

overwrite view_seq_bold for wiki

=cut

sub view_seq_bold {
  my ($self, $text) = @_;
  return "**$text**";
}

=head2 view_seq_italic

overwrite view_seq_italic for wiki

=cut

sub view_seq_italic {
  my ($self, $text) = @_;
  return "//".$text."//";
}

use String::CamelCase 'decamelize';

sub view_seq_link {
    my ($self, $link) = @_;

    # view_seq_text has already taken care of L<http://example.com/>
    if ($link =~ /^\[\[/ ) {
        return $link;
    }

    my @link_parts = split /\//, $link;

    my $prefix = $ENV{WIKI_LINK_PREFIX} || "";
    my $suffix = $ENV{WIKI_LINK_SUFFIX} || "";
    $prefix .= ":" if $prefix;
    $suffix = ":".$suffix if $suffix;

    if (scalar(@link_parts) == 2 ) {
        return "[[$prefix" . decamelize($link_parts[0]) . "$suffix#". $link_parts[1] ."|" . $link_parts[1] . "]]";
    }

    return $link;

}



=head1 AUTHOR

Nicolas Oudard, C<< <nicolas at oudard.org> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-pod-pom-view-wiki at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Pod-POM-View-Wiki>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.


=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Pod::POM::View::Wiki


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Pod-POM-View-Wiki>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Pod-POM-View-Wiki>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Pod-POM-View-Wiki>

=item * Search CPAN

L<http://search.cpan.org/dist/Pod-POM-View-Wiki/>

=back


=head1 ACKNOWLEDGEMENTS


=head1 LICENSE AND COPYRIGHT

Copyright 2010 Nicolas Oudard.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.


=cut

1; # End of Pod::POM::View::Wiki
