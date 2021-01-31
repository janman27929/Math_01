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

sub test_base : Test(no_plan) {
  #my @mocks = set_mocks [(qw(MODULE METHOD MOCK))];

  my $self  = shift->{base};  
  #$self->setup;
  is  ref $self, 'Math_01', 'is: ref $self';
  print '-'x30, '[ test_Math_01 ]', '-'x30 ,"\n";
  $DB::single = 1; 
  $DB::single = 1; 
}

#-------------------------------[ Infra commands ]-----------------------------
if (! caller()) {Test::Class->runtests}

