% Conversão de ângulos de Euler 123 para matriz de atitude D
function D  = a2D(a)

D = zeros(3);

c1 = cos(a(1)); s1 = sin(a(1));
c2 = cos(a(2)); s2 = sin(a(2));
c3 = cos(a(3)); s3 = sin(a(3));

D(1,:) = [c3*c2, c3*s2*s1 + s3*c1, -c3*s2*c1 + s3*s1];
D(2,:) = [-s3*c2, -s3*s2*s1 + c3*c1, s3*s2*c1 + c3*s1];
D(3,:) = [s2, -c2*s1, c2*c1];

