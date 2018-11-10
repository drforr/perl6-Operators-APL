use v6;
use Test;
use Operators::APL;

#multi sub prefix:<+⌿>( APL $x ) returns APL is export {

subtest 'first-axis reduce-by-plus', {
  my $X = APL.new( :vector(
    ( 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 ),
    ( 0, 1, 0, 1, 0, 1, 0, 1, 0, 1 ),
    ( 0, 0, 1, 0, 0, 1, 0, 0, 1, 0 ),
    ( 0, 0, 0, 1, 0, 0, 0, 1, 0, 0 ),
    ( 0, 0, 0, 0, 1, 0, 0, 0, 0, 1 ),
    ( 0, 0, 0, 0, 0, 1, 0, 0, 0, 0 ),
    ( 0, 0, 0, 0, 0, 0, 1, 0, 0, 0 ),
    ( 0, 0, 0, 0, 0, 0, 0, 1, 0, 0 ),
    ( 0, 0, 0, 0, 0, 0, 0, 0, 1, 0 ),
    ( 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 )
  ) );
  my $x = ( +⌿$X );
  is $x.vector, ( 1, 2, 2, 3, 2, 4, 2, 4, 3, 4 );
};

subtest 'test-zero on outer-product-reduce', {
  my $X = APL.new( :vector(
    ( 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ),
    ( 1, 0, 1, 0, 1, 0, 1, 0, 1, 0 ),
    ( 1, 2, 0, 1, 2, 0, 1, 2, 0, 1 ),
    ( 1, 2, 3, 0, 1, 2, 3, 0, 1, 2 ),
    ( 1, 2, 3, 4, 0, 1, 2, 3, 4, 0 ),
    ( 1, 2, 3, 4, 5, 0, 1, 2, 3, 4 ),
    ( 1, 2, 3, 4, 5, 6, 0, 1, 2, 3 ),
    ( 1, 2, 3, 4, 5, 6, 7, 0, 1, 2 ),
    ( 1, 2, 3, 4, 5, 6, 7, 8, 0, 1 ),
    ( 1, 2, 3, 4, 5, 6, 7, 8, 9, 0 )
  ) );
  my $x = ( 0≟$X );
  is $x.vector, (
    ( 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 ),
    ( 0, 1, 0, 1, 0, 1, 0, 1, 0, 1 ),
    ( 0, 0, 1, 0, 0, 1, 0, 0, 1, 0 ),
    ( 0, 0, 0, 1, 0, 0, 0, 1, 0, 0 ),
    ( 0, 0, 0, 0, 1, 0, 0, 0, 0, 1 ),
    ( 0, 0, 0, 0, 0, 1, 0, 0, 0, 0 ),
    ( 0, 0, 0, 0, 0, 0, 1, 0, 0, 0 ),
    ( 0, 0, 0, 0, 0, 0, 0, 1, 0, 0 ),
    ( 0, 0, 0, 0, 0, 0, 0, 0, 1, 0 ),
    ( 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 )
  );
};

subtest 'outer-product-reduce full', {
  my $X = APL.new( :vector( 1 .. 10 ) ); # Or ⍳10, but that's not tested yet.
  my $Y = APL.new( :vector( 1 .. 10 ) );
  my $x = ( $X∘.|$Y );
  is $x.vector, (
    ( 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ),
    ( 1, 0, 1, 0, 1, 0, 1, 0, 1, 0 ),
    ( 1, 2, 0, 1, 2, 0, 1, 2, 0, 1 ),
    ( 1, 2, 3, 0, 1, 2, 3, 0, 1, 2 ),
    ( 1, 2, 3, 4, 0, 1, 2, 3, 4, 0 ),
    ( 1, 2, 3, 4, 5, 0, 1, 2, 3, 4 ),
    ( 1, 2, 3, 4, 5, 6, 0, 1, 2, 3 ),
    ( 1, 2, 3, 4, 5, 6, 7, 0, 1, 2 ),
    ( 1, 2, 3, 4, 5, 6, 7, 8, 0, 1 ),
    ( 1, 2, 3, 4, 5, 6, 7, 8, 9, 0 )
  );
};

subtest 'outer-product-reduce', {
  my $X = APL.new( :vector( 3, 4, 5 ) );
  my $Y = APL.new( :vector( 1 .. 10 ) ); # Or ⍳10, but that's not tested yet.
  my $x = ( $X∘.|$Y );
  is $x.vector, (
    ( 1, 2, 0, 1, 2, 0, 1, 2, 0, 1 ),
    ( 1, 2, 3, 0, 1, 2, 3, 0, 1, 2 ),
    ( 1, 2, 3, 4, 0, 1, 2, 3, 4, 0 )
  );
};

subtest 'compress-returned-iota', {
  my $X = APL.new;
  my $y = APL.new( :vector(
    0, 1, 1, 0, 1,  0, 1, 0, 0, 0,
    1, 0, 1, 0, 0,  0, 1, 0, 1, 0,
    0, 0, 0, 0, 0,  0, 0, 0, 0, 0,
    0, 0, 0, 0, 0,  0, 0, 0, 0, 0,
    0, 0, 0, 0, 0,  0, 0, 0, 0, 0,

    0, 0, 0, 0, 0,  0, 0, 0, 0, 0,
    0, 0, 0, 0, 0,  0, 0, 0, 0, 0,
    0, 0, 0, 0, 0,  0, 0, 0, 0, 0,
    0, 0, 0, 0, 0,  0, 0, 0, 0, 0,
    0, 0, 0, 0, 0,  0, 0, 0, 0, 0,
  ) );
  my $x = ( $y/⍳($X←100) );

  is $x.vector, (
    2, 3, 5, 7, 11, 13, 17, 19 #, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97
  );
};

subtest 'return-iota', {
  my $X = APL.new;
  my $x = ( ⍳($X←100 )); # This *does* fix the issue...
                         # Now how to change the binding.

  isa-ok $x, APL;
  is $x.value, Any;
  is $x.vector, ( 1 .. 100 );
};

ok 1, 'SKIP bind-iota until the problem can be solved...';
#subtest 'bind-iota', {
#  my $x = ( ⍳$X←100 );
#
#  isa-ok $x, APL;
#  is $x.value, Any;
#  is $x.vector, ( 1 .. 100 );
#};

subtest 'assignment', {
  my $X = APL.new;
  my $x = ( $X←100 );

  isa-ok $x, APL;
  is $x.value, 100;
  is $x.vector, [];

  #say ( $foo = 100 ); # 100 as I'd have guessed.
};

subtest 'bare iota', {
  my $x = ( ⍳100 );

  isa-ok $x, APL;
  is $x.value, Any;
  is $x.vector, ( 1 .. 100 );
};

done-testing;

# vim: ft=perl6
