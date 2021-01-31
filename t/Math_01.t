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

sub add_em : Test(no_plan) {
  print '-'x30, '[ add_em ]', '-'x30 ,"\n";
  my $self  = shift->{base};  
  is  $self->add_em(1,2,3), 6, 'is: add_em: 6';
  is  $self->add_em(1), 1, 'is: add_em: 1';
  is  $self->add_em(), 0, 'is: add_em: 1';
  like ( dies { $self->add_em(1,sub{9},2) }, qr/no refs:/,"no refs:"); 
  is  $self->add_em(undef), 0, 'is: add_em: 1';
  like ( dies { $self->add_em(12,'cat','two',1) }, qr/bad num/,"bad num:cat "); 
  #$self->set_tracer;
  is  $self->add_em(1,'12', 1, -1), 13, 'is: add_em: 1';
  is  $self->add_em(1, 10.5, -1.5, 1, -1), 10, 'is: add_em: 10';
  $DB::single = 1; 
  $DB::single = 1; 
}


#-------------------------------[ Infra commands ]-----------------------------
if (! caller()) {Test::Class->runtests}

