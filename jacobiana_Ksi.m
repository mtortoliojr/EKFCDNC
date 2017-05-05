%%--------------------------------------------------------------------------------
%% Função para o cálculo da matrix de cinemática de atitude em relação de alfa
%%--------------------------------------------------------------------------------
function dKsi = jacobiana_Ksi(q)

% Componentes do quatérnio
q1 = q(1); q2 = q(2);
q3 = q(3); q4 = q(4);

% dKsi1 = d(Ksi)/d(q1)
dKsi1 = [0  0  0;
		 0  0 -1;
		 0  1  0;
		 1  0  0];

% dKsi2 = d(Ksi)/d(q2)
dKsi2 = [0  0  1;
		 0  0  0;
		-1  0  0;
		 0 -1  0];

% dKsi3 = d(Ksi)/d(q3)
dKsi3 = [0 -1  0;
		 1  0  0;
		 0  0  0;
		 0  0 -1];

% dKsi4 = d(Ksi)/d(q4)
dKsi4 = [1  0  0;
		 0  1  0;
		 0  0  1;
		 0  0  0];

% Definição da Jacobiana da matriz Ksi em relação a q
% d(Ksi)/d(q) = [dKsi1,dKsi2,dKsi3,dKsi4];
dKsi = [dKsi1,dKsi2,dKsi3,dKsi4];

end
