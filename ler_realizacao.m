%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Função para ler uma realização do arquivo .mat
% Parâmetros:
%
% 1) filename: arquivo com o banco de realizações; 
% 2) idx: índice da realização desejada;
% 3) t: tempo final desejado.
%
% OBS 1: nome do arquivo
%	filename = realizacao_<N>_<tf>s.mat
%	<N> : número total de realizações do arquivo;
%	<tf> : tempo total de simulação;
% Ex: filename = 'realizacao_100_120s.mat', então
%     100 realizações de 120 segundos cada.
%
% OBS 2: o índice r deve estar no intervalo de 1 a N, onde N corresponde
% 		ao número total de realizações do arquivo;
%
% OBS 3: o tempo final desejado deve estar no intervalo de 1 a tf, onde
% 		tf corresponde ao tempo total de simulação. 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [x,u,r,y] = ler_realizacao(filename,idx,t);

% Carrega as matrizes de realizações
% XN = [x1;...;xN]: N matrizes de realizações de x empilhadas
% UN = [u1;...;yN]: N matrizes de realizações de u empilhadas
% YN = [y1;...;yN]: N matrizes de realizações de y empilhadas
load(filename,'N','tf','XN','UN','BN','RN','YN');

% Dimensão dos vetores x, u e y
nx = 6; nu = 3; ny = 8;

% Período de amostragem dos sensores
Ts = 0.05; 

% Realização r
r = RN(:,1:t/Ts+1);

% Realização u de índice idx
j1 = nu * (idx-1) + 1; j2 = j1 + nu - 1;
u = UN(j1:j2,1:t/Ts+1);

% Realização b de índice idx
j1 = nu * (idx-1) + 1; j2 = j1 + nu - 1;
b = BN(j1:j2,1:t/Ts+1);

% Realização x
x = XN(:,1:t/Ts+1);
x(4:6,:) = b;

% Realização y de índice idx 
j1 = ny * (idx-1) + 1; j2 = j1 + ny - 1;
y = YN(j1:j2,1:t/Ts+1);

end
