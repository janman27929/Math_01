use lib qw(. .. t lib ../lib);
use Modern::Perl;

package Common {
use base qw(RDD);

sub do_math {
  my ($self,@parms) = @_;
  return 0 unless @parms;
  $self->init_total;
  for (@parms) {
    next unless defined;
    $self->prn_tracer('div_11',$self->get_total,$_);
    next if $self->seed($_);
    $self->verify($_);
    $self->bump_total($_);
    $self->prn_tracer('div_21',$self->get_total,$_);
  }
  return $self->get_final;
}

sub init_total { $_[0]->set_total (undef) }

sub seed { 
  return 0 if defined $_[0]->get_total;
  $_[0]->set_total($_[1]);
  return 1;
}

sub verify {
  my ($self,$num) = @_;
  die ("FAIL: no refs:\n") if  (ref $num);
  die ("FAIL: bad num:$_:\n") unless ($num =~ /^[-+]*\d*\.*\d+$/);
}
sub get_final  {$_[0]->get_total}

}

package Add {
use base qw(Common);

my $total;

sub get_total  { $total}
sub set_total  { $total = $_[1]}
sub bump_total { $total += $_[1] }

}

package Subtract {
use base qw(Common);

my $total;

sub get_total  { $total}
sub set_total  { $total = $_[1]}
sub bump_total { $total -= $_[1] }

}

package Multiply {
use base qw(Common);

my $total;

sub get_total  { $total }
sub set_total  { $total = $_[1]}
sub bump_total { $total *= $_[1] }

}


package Divide {
use base qw(Common);

my $total;

sub get_total  { $total}
sub set_total  { $total = $_[1]}
sub bump_total { $total /= $_[1] }

sub verify {
  my ($self,$num) = @_;
  $self->NEXT::verify($num);
  die ("FAIL: div by zero:\n") if ($num == 0);
}

}

package Statistics {
use base qw(Common);
use Statistics::Basic;

my @nums;
sub get_total  { @nums }
sub set_total  {  }
sub seed       { 0 }
sub init_total { @nums = () }
sub bump_total { push @nums, $_[1] }

}#-- Statistics

package Statistics::Stddev {
use base qw(Statistics);

sub get_final  { 
  return undef unless $_[0]->get_total;
  Statistics::Basic::stddev($_[0]->get_total); 
}

}#-- Statistics::Stddev

package Statistics::Median {
use base qw(Statistics);

sub get_final  { 
  return undef unless $_[0]->get_total;
  $DB::single = 1; 
  Statistics::Basic::median($_[0]->get_total); 
}

}#-- Statistics::Stddev


package Statistics::Average {
use base qw(Statistics);

sub get_final  { 
  return undef unless $_[0]->get_total;
  Statistics::Basic::average($_[0]->get_total); 
}

}#-- Statistics::Average


package Math_01 {
use base qw(RDD);

my %objs = (
  add_em      => Add->new(),
  divide_em   => Divide->new(),
  subtract_em => Subtract->new(),
  multiply_em => Multiply->new(),
  average_em  => Statistics::Average->new(),
  stddev_em   => Statistics::Stddev->new(),
  median_em   => Statistics::Median->new(),
);

sub add_em      {shift; $objs{add_em}->do_math(@_)}
sub divide_em   {shift; $objs{divide_em}->do_math(@_)}
sub multiply_em {shift; $objs{multiply_em}->do_math(@_)}
sub average_em  {shift; $objs{average_em}->do_math(@_)}
sub subtract_em {shift; $objs{subtract_em}->do_math(@_)}
sub stddev_em   {shift; $objs{stddev_em}->do_math(@_)}
sub median_em   {shift; $objs{median_em}->do_math(@_)}


1;
}#----- Math_01 -----

