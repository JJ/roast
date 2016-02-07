use Test;
plan 8;

# L<S03/"Junctive and (all) precedence"/"infix:<&>">

#doc-roast 'operators','&infix:«S&»','sequential meta-operator to force order of &infix:«&»'
ok ?(1 S& 2),         "basic infix:<S&>";
#?niecza skip 'Excess arguments to CORE seqop, used 3 of 4 positionals'
ok ?(1 S& 2 S& 3), "basic infix:<S&> (multiple S&'s)";
#?rakudo todo 'nom regression RT #124544'
ok !(0 S& 1),         "S& has and-semantics (first term 0)";
#?rakudo todo 'nom regression RT #124545'
ok !(1 S& 0),         "also has and-semantics (second term 0)";

my $x = '';

ok ?('a' ~~ { $x ~= "b"; True } S& { $x ~= "c"; True }), 'S& with two blocks';
#?rakudo todo 'nom regression RT #124546'
is $x, 'bc', 'blocks called in the right order';

my $executed = 0;

#?rakudo todo 'nom regression RT #124547'
ok !('a' ~~ 'b' S& { $executed = 1; True }), 'and semantics';
#?niecza todo
ok !$executed,                            'short-circuit';

# vim: ft=perl6
