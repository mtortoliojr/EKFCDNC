% convert from q to D
function D = q2D(q)

e = q(1:3);
n = q(4);

cross_e = [0 -e(3) e(2);e(3) 0 -e(1);-e(2) e(1) 0];

D  = (n^2-e'*e)*eye(3) + 2*e*(e') - 2*n*cross_e;