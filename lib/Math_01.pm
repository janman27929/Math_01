use lib qw(. .. t lib ../lib);
use Modern::Perl;

package Math_01 {
use base qw(RDD);

sub new       {
  my ($class, %parms) = @_;
  my %defaults = (
  );
  my $self = $class->NEXT::new(%defaults, %parms);
  $self;
}

sub add_em {
  my ($self, @parms) = @_;
  return 0 unless @parms;
  my $total = 0;
  for (@parms) {
    $self->prn_tracer('add_01',$total,$_);
    next unless defined;
    $self->verify($_);
    $total += $_;
    $self->prn_tracer('add_21',$total,$_);
  }
  return $total;
}

sub verify {
  my ($self,$num) = @_;
  die ("FAIL: no refs:\n") if  (ref $num);
  die ("FAIL: bad num:$_:\n") unless ($num =~ /^[-+]*\d*\.*\d+$/);
}


1;
}#----- Math_01 -----

