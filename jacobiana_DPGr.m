%%--------------------------------------------------------------------------------
%% Função para o cálculo da Jacobiana de D(q)r em relação a q
%%--------------------------------------------------------------------------------
function dD = jacobiana_DPGr(q,r)

D = q2D(q);
DrX = matriz_skew(D*r);
Ksi = matriz_Ksi(q);

% Jacobiana
dD = (2 * DrX * Ksi') / (norm(q)^2);

end
