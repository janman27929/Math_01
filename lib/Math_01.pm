use lib qw(. .. t lib ../lib);
use Modern::Perl;

package Math_01 {
use base qw(RDD);

sub new {
  my %defaults = ();
  my $self=shift;$self=$self->NEXT::new(%defaults, @_)
}

sub setup     {my $self=shift;$self->NEXT::setup(@_)         }
sub teardown  {my $self=shift;$self->NEXT::teardown(@_)      }



sub main     { 
  my $self = shift;  
  $self;
}

1;
}#----- Math_01 -----

=head1 NAME

Math_01

< description_here NOTE: use "ca<" to change text within > 

=head1 DESCRIPTION

< description_here NOTE: use "ca<" to change text within > 

=head1 SYNOPSIS

< example usage > 

=cut
