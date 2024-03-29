# -*- Mode: CPerl -*-
# t/03_setops.t: test cmpvec, vv_qsortvec, vsearchvec

$TEST_DIR = './t';
#use lib qw(../blib/lib ../blib/arch); $TEST_DIR = '.'; # for debugging

# load common subs
use Test;
do "$TEST_DIR/common.plt";
use PDL;
use PDL::VectorValued;

BEGIN { plan tests=>9, todo=>[]; }

##--------------------------------------------------------------
## data
our $universe = pdl(long,[ [0,0],[0,1],[1,0],[1,1] ]);
our $v1 = $universe->dice_axis(1,pdl([0,1,2]));
our $v2 = $universe->dice_axis(1,pdl([1,2,3]));

## 1..3: union
($c,$nc) = $v1->vv_union($v2);
isok("vv_union:list:c",  all($c==pdl([ [0,0],[0,1],[1,0],[1,1],[0,0],[0,0] ])));
isok("vv_union:list:nc", $nc==$universe->dim(1));
$cc = $v1->vv_union($v2);
isok("vv_union:scalar", all($cc==$universe));

## 4..6: intersect
($c,$nc) = $v1->vv_intersect($v2);
isok("vv_intersect:list:c", all($c==pdl([ [0,1],[1,0],[0,0] ])));
isok("vv_intersect:list:nc", $nc==$v1->dim(1));
$cc = $v1->vv_intersect($v2);
isok("vv_intersect:scalar", all($cc==$universe->slice(",1:2")));

## 7..9: intersect
($c,$nc) = $v1->vv_setdiff($v2);
isok("vv_setdiff:list:c", all($c==pdl([ [0,0], [0,0],[0,0] ])));
isok("vv_setdiff:list:nc", $nc==1);
$cc = $v1->vv_setdiff($v2);
isok("vv_setdiff:scalar", all($cc==pdl([[0,0]])));

print "\n";
# end of t/03_setops.t

