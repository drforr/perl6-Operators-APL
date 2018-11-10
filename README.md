# Operators-APL [![Build Status](https://secure.travis-ci.org/drforr/perl6-Operators-APL.svg?branch=master)](http://travis-ci.org/drforr/perl6-Operators-APL)
Operators-APL
=======

Defines APL operators for Perl 6

Currently it's rather clumsy and assumes an C<APL> class exists to work with,
because that's a decent way to start a chain.

Also note that this so far only handles the operators in the somewhat infamous
prime one-liner. Also note '∘.|' is actually several distinct operators in
APL, but for the moment I've put them together in one infix operator because
I'm not sure how well Perl 6 can handle the actual operators.

Got some ideas, but those can wait.

Installation
============

* Using zef (a module management tool bundled with Rakudo Star):

```
    zef update && zef install Operators-APL
```

## Testing

To run tests:

```
    prove -e perl6
```

## Author

Jeffrey Goff, DrForr on #perl6, https://github.com/drforr/

## License

Artistic License 2.0
