%%--------------------------------------------------------------------------------
%% Função para o cálculo da Jacobiana de DPG em relação a alfa
%%--------------------------------------------------------------------------------
function dDPG = jacobiana_DPG(q,r)

% Quatérnios
q1 = q(1); 
q2 = q(2);
q3 = q(3); 
q4 = q(4);

% Definição da Jacobiana da matriz DPG em relação à q
% d(DPG)/d(q) = [dD1, dD2, dD3, dD4];

% dDPG1 = d(DPG)/d(q1)
dDPG1 = 2*[q1,q2,q3;q2,-q1,q4;q3,-q4,-q1];

% dDPG2 = d(DPG)/d(q2)
dDPG2 = 2*[-q2,q1,-q4;q1,q2,q3;q4,q3,-q2];
 
% dDPG3 = d(DPG)/d(q3)
dDPG3 = 2*[-q3,q4,q1;-q4,-q3,q2;q1,q2,q3];

% dDPG4 = d(DPG)/d(q4)
dDPG4 = 2*[q4,q3,-q2;-q3,q4,q1;q2,-q1,q4];

% Jacobiana
dDPG = [dDPG1,dDPG2,dDPG3,dDPG4];

end
