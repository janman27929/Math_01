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
  $self->prn_tracer('add_00',$#parms);
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

sub subtract_em {
  my ($self, @parms) = @_;
  return 0 unless @parms;
  my $total = 0;
  for (@parms) {
    $self->prn_tracer('sbt_11',$total,$_);
    next unless defined;
    next if $self->seed(\$total, $_);
    $self->verify($_);
    $total -= $_;
    $self->prn_tracer('sbt_21',$total,$_);
  }
  return $total;
}

sub multiply_em {
  my ($self, @parms) = @_;
  return 0 unless @parms;
  my $total = 0;
  for (@parms) {
    $self->prn_tracer('mlt_11',$total,$_);
    next unless defined;
    next if $self->seed(\$total, $_);
    $self->verify($_);
    $total *= $_;
    $self->prn_tracer('mlt_21',$total,$_);
  }
  return $total;
}

sub divide_em {
  my ($self, @parms) = @_;
  return 0 unless @parms;
  my $total = 0;
  for (@parms) {
    $self->prn_tracer('div_11',$total,$_);
    next unless defined;
    next if $self->seed(\$total, $_);
    $self->verify($_);
    die ("FAIL: div by zero:\n") if ($_ == 0);
    $total /= $_;
    $self->prn_tracer('div_21',$total,$_);
  }
  return $total;
}

sub seed {
  my ($self, $r_total, $num) = @_;
  return 0 if $$r_total;
  $$r_total = $num;
  return 1;
}

sub verify {
  my ($self,$num) = @_;
  die ("FAIL: no refs:\n") if  (ref $num);
  die ("FAIL: bad num:$_:\n") unless ($num =~ /^[-+]*\d*\.*\d+$/);
}


1;
}#----- Math_01 -----

