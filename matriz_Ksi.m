%%--------------------------------------------------------------------------------
%% Função para o cálculo da matrix de cinemática de atitude em função de alfa
%%--------------------------------------------------------------------------------
function Ksi = matriz_Ksi(q)

% Componentes do quatérnio
q13 = q(1:3);
q4 = q(4);

% Matriz [q13 X]
q13X = [0 -q13(3) q13(2); q13(3) 0 -q13(1); -q13(2) q13(1) 0];

% Definição da Theta
Ksi = [q4*eye(3) + q13X; -q13'];

end
