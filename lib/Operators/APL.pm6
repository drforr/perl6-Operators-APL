use v6;

=begin pod

=head1 NAME

Operators::APL

=head1 SYNOPSIS

    use Operators::APL;

    # Print the primes from 2 to 100 using Eratosthenes' Sieve.
    say 2≟+⌿0≟(⍳X)∘.|⍳X)/⍳X←100;

=head1 DOCUMENTATION

Use APL operators in Perl 6.

For the moment, I'm creating an 'APL' class that these operators glom onto.
I'm sure there are better ways of doing this, but I'll deal with the packaging
after the semantics are properly done.

=head2 Operators

=over 4

=item ≟ U+225F

The C<test> operator, which is properly spelled '=' in APL, but that's something
that either can't be declared, or I just haven't figured out how to declare it.

=item +⌿ U+233F - The U+233F is really the operator, but +⌿ is how it groups.

First Axis Reduction

=item ∘. U+2218 

Outer Product

=item |

Residue

=item ⍳ U+2373

Iota

Prefix operator, given an integer C<$c> it returns C<(1 .. $c)>

=back

=end pod

class APL {
  has $.value;
  has @.vector;
}

# Assignment
#
multi sub infix:<←>( APL $x, Int $y ) returns APL is export {
  APL.new( :value( $y ) )
}

multi sub prefix:<+⌿>( APL $x ) returns APL is export {
  my @v;
  for 0 .. $x.vector.elems - 1 -> $X {
    my $sum = 0;
    for 0 .. $x.vector[0].elems - 1 -> $Y {
      $sum += $x.vector[$Y][$X]
    }
    @v[$X] = $sum
  }
  APL.new( :vector( @v ) )
}

# Yes, the compression operator can probably be written in a much more
# functional style, but I'm not going to worry about it at the moment.
#
multi sub infix:</>( APL $x, APL $y ) returns APL is export {
  my @v;
  for 0 .. $x.vector.elems - 1 -> $X {
    @v.push( $y.vector[$X] ) if $x.vector[$X] > 0
  }
  APL.new( :vector( @v ) )
}

# Test operator (this deviates from APL because it was written back before
#                we'd settled on '=' as assignment. It's really a test, and
#                probably is better done as a reduction operator really.)
#
multi sub infix:<≟>( Int $x, APL $y ) returns APL is export { # U+225f, not =
  my @v;
  for 0 .. $y.vector.elems - 1 -> $X {
    for 0 .. $y.vector[0].elems - 1 -> $Y {
      @v[$X][$Y] = $y.vector[$X][$Y] == $x ?? 1 !! 0
    }
  }
  APL.new( :vector( @v ) )
}

# XXX Actually C<∘.> followed by C<|>, because C< ∘.> is the
# XXX Outer Product operator.
# XXX
multi sub infix:<∘.|>( APL $x, APL $y ) returns APL is export {
  # Actually $x.vector x $y.vector?
#  APL.new( :vector( $x.vector x $y.vector ) )

  # There's of course a much simpler way to write this, I just have to figure
  # out what that way is.
  #
  my @v;
  for 0 .. $x.vector.elems - 1 -> $X {
    for 0 .. $y.vector.elems - 1 -> $Y {
      @v[$X][$Y] = $y.vector[$Y] mod $x.vector[$X]
    }
  }
  APL.new( :vector( @v ) )
}

multi sub prefix:<⍳>( Int $x ) returns APL is export {
  return APL.new( :vector( 1 .. $x ) )
}

multi sub prefix:<⍳>( APL $x ) returns APL is export {
  if $x.value {
    return APL.new( :vector( 1 .. $x.value ) )
  }
  else {
    return APL.new
  }
}

# vim: ft=perl6
