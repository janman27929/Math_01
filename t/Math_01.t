use lib qw(. .. t lib ../lib);

use v5.16;
use Test2::V0; 
use Test2::Plugin::DieOnFail;
use Modern::Perl;
use Carp::Always;
require Rdd_Mocks;

use base qw(Test::Class);

my $pkg_name = 'Math_01';

my @global_mock_defs=();
my @mocks=();
my $mock_fname = qq(t/$pkg_name.mock);



#-------------------------[ TEST HARNESS METHODS HERE ]-------------------------
# this runs only ONCE, on program startup
sub startup   : Test(startup) {
  my $objs = shift;
  require $pkg_name . ".pm";

  load_mock($mock_fname);
  @mocks = set_mocks (@global_mock_defs);
}

# this runs BEFORE each and every test
sub setup : Test(setup) {
  my $objs = shift;
  $objs->{base} = Math_01->new(
  );  
}

# this runs AFTER each and every test
sub teardown : Test(teardown) {
  my $self = shift;
}

# this runs only ONCE, on program exit
sub shutdown  : Test(shutdown) {
  my $self = shift;
}

#-------------------------------[ UNIT TESTS HERE ]-----------------------------
sub divide_em : Test(no_plan) {
  print '-'x30, '[ divide_em ]', '-'x30 ,"\n";
  my $self  = shift->{base};  
  #$self->set_tracer;
  is  $self->divide_em(44,2,11), 2, 'is: divide_em: 2';
  is  $self->divide_em(1), 1, 'is: divide_em: 1';
  like ( dies { $self->divide_em(1,0,12) }, qr/div by zero/,"div by zero"); 
  is  $self->divide_em(), 0, 'is: divide_em: 0';
  like ( dies { $self->divide_em(1,sub{9},2) }, qr/no refs:/,"no refs:"); 
  is  $self->divide_em(undef), undef, 'is: divide_em: undef';
  like ( dies { $self->divide_em(12,'cat','two',1) }, qr/bad num/,"bad num:cat "); 
  is  $self->divide_em(144,'12', 2, -1), -6, 'is: divide_em: -6';
  is  $self->divide_em(10.5, -1.5, 1, -1), 7, 'is: divide_em: 7';
}

sub multipy_em : Test(no_plan) {
  print '-'x30, '[ mutiply_em ]', '-'x30 ,"\n";
  my $self  = shift->{base};  
  #$self->set_tracer;
  is  $self->multiply_em(11,2,3), 66, 'is: multiply_em: 66';
  is  $self->multiply_em(1), 1, 'is: multiply_em: 1';
  is  $self->multiply_em(1,0), 0, 'is: multiply_em: 0';
  is  $self->multiply_em(), 0, 'is: multiply_em: 0';
  like ( dies { $self->multiply_em(1,sub{9},2) }, qr/no refs:/,"no refs:"); 
  is  $self->multiply_em(undef), undef, 'is: multiply_em: undef';
  like ( dies { $self->multiply_em(12,'cat','two',1) }, qr/bad num/,"bad num:cat "); 
  is  $self->multiply_em(1,'12', 2, -1), -24, 'is: multiply_em: -11';
  is  $self->multiply_em(1, 10.5, -1.5, 1, -1), 15.75, 'is: multiply_em: 15.75';
}

sub subtract_em : Test(no_plan) {
  print '-'x30, '[ subtract_em ]', '-'x30 ,"\n";
  my $self  = shift->{base};  
  #$self->set_tracer;
  is  $self->subtract_em(11,2,3), 6, 'is: subtract_em: 6';
  is  $self->subtract_em(1), 1, 'is: subtract_em: 1';
  is  $self->subtract_em(), 0, 'is: subtract_em: 1';
  like ( dies { $self->subtract_em(1,sub{9},2) }, qr/no refs:/,"no refs:"); 
  is  $self->subtract_em(undef), undef, 'is: subtract_em: undef';
  like ( dies { $self->subtract_em(12,'cat','two',1) }, qr/bad num/,"bad num:cat "); 
  is  $self->subtract_em(1,'12', 1, -1), -11, 'is: subtract_em: -11';
  is  $self->subtract_em(1, 10.5, -1.5, 1, -1), -8, 'is: subtract_em: -8';
}


sub add_em : Test(no_plan) {
  print '-'x30, '[ add_em ]', '-'x30 ,"\n";
  my $self  = shift->{base};  
  is  $self->add_em(1,2,3), 6, 'is: add_em: 6';
  is  $self->add_em(1), 1, 'is: add_em: 1';
  is  $self->add_em(), 0, 'is: add_em: 1';
  like ( dies { $self->add_em(1,sub{9},2) }, qr/no refs:/,"no refs:"); 
  is  $self->add_em(undef), undef, 'is: add_em: 1';
  like ( dies { $self->add_em(12,'cat','two',1) }, qr/bad num/,"bad num:cat "); 
  is  $self->add_em(1,'12', 1, -1), 13, 'is: add_em: 1';
  is  $self->add_em(1, 10.5, -1.5, 1, -1), 10, 'is: add_em: 10';
}


#-------------------------------[ Infra commands ]-----------------------------
if (! caller()) {Test::Class->runtests}

