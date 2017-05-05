%%--------------------------------------------------------------------------------
%% Função para o cálculo de g(x)
%%--------------------------------------------------------------------------------
function g = funcao_g(x)

% Componente q de x
q = x(1:4);

% Cálculo da matrix Ksi
Ksi = matriz_Ksi(q);

% --------------------------------------------------------------
% g(x)
% --------------------------------------------------------------
g = zeros(7,6);
g(1:4,1:3) = -0.5 * Ksi;
g(5:7,4:6) = eye(3);

end