%%--------------------------------------------------------------------------------
%% Função para o cálculo de f(x,u)
%%--------------------------------------------------------------------------------
function f = funcao_f(x,u)

% Parâmetros físicos
param = ler_parametros();

% Componentes de u
wp = u;

% Vetor g
g = param.fisico.g;
gG = [0 0 -g]';

% Estados q e b
q = x(1:4);
b = x(5:7);

% Cálculo da matriz Ksi
Ksi = matriz_Ksi(q);

% --------------------------------------------------------------
% f(x,u)
% --------------------------------------------------------------
f = [0.5 * Ksi * (wp - b); 0; 0; 0];

end
