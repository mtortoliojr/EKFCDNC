%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Função para gerar realizações da plataforma e salvar em um arquivo .mat
% Parâmetros:
% 1) N: número de realizações; 
% 2) tf: tempo de simulação em segundos.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

close all;
clear all;
clc;

warning('off','all')
warning

% Número de realizações
N = 10;

% Tempo de simulação em segundos
tf = 50;

% Dimensão dos vetores x, u e y
nx = 6; nu = 3; ny = 8;

% Período de amostragem dos sensores
Ts = 0.05; 

% Inicialização das matrizes das realizações de x, u e y
XN = zeros(nx,tf/Ts+1);
UN = zeros(nu*N,tf/Ts+1);
RN = zeros(3,tf/Ts+1);
BN = zeros(nu*N,tf/Ts+1);
YN = zeros(ny*N,tf/Ts+1);

% Loop de simulação
for j = 1:N

	disp(['Realização ',num2str(j),'/',num2str(N)]);
    
    %% Simulação da plataforma 
    sim('plataforma');

    % Bias do giro
	j1 = nu * (j-1) + 1; j2 = j1 + nu - 1;	
    BN(j1:j2,:) = [bg.signals.values'];

    % Medidas dos sensores y
	j1 = nu * (j-1) + 1; j2 = j1 + nu - 1;	
    UN(j1:j2,:) = [wm.signals.values'];

    % Medidas dos sensores u
	j1 = ny * (j-1) + 1; j2 = j1 + ny - 1;	
    YN(j1:j2,:) = [y1.signals.values';y2.signals.values';y3.signals.values';y4.signals.values'];    
	    
end

% Estados verdadeiros x
%XN = [a.signals.values';bg.signals.values'];
XN(1:3,:) = a.signals.values';

% Posições do veículo
RN = r.signals.values';

% Salva as matrizes em um arquivo .mat
filename = ['realizacao_',num2str(N),'_',num2str(tf),'s.mat'];
save(filename,'N','tf','XN','UN','BN','RN','YN');
disp(['Arquivo: ',filename]);


