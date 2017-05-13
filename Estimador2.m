%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Simula��o MC de algoritmos de navega��o
% Problema: Inertial-Vision Navigation from Landmark Vector Measurements
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Autor: Prof. Davi Ant�nio dos Santos
% Local: Instituto Tecnol�gico de Aerona�tica
% Data: 12/10/2016
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc;
close all;
clear;

warning('off','all')
warning

seed_offset = 1;

disp(['***** Estimador de Atitude *****']);

%% Parametros da simulação
N = 10;     % n�mero de realiza��es para a simula��o MC
tf = 50;   % tempo de simula��o
Ts = 0.05;  % per�odo de amostragem dos sensores

%% Loop de Simula��o Monte Carlo

% Inicializa��es de �ndices de desempenho
ea = zeros(1,tf/Ts+1);
m_e = zeros(4,tf/Ts+1);          % m�dia do erro de estima��o de x 
sigma_be = zeros(4,tf/Ts+1);      % desvio padr�o do erro de estima��o de x

% Arquivo de realizações
filename = ['realizacao_',num2str(N),'_',num2str(tf),'s.mat'];
disp(['Arquivo: ',filename]);

% Loop da simula��o MC
for j = 1:N

	disp(['Realização ',num2str(j),'/',num2str(N)]);
    	
    % Estados verdadeiros e medida dos sensores
	[x,u,r,y] = ler_realizacao(filename,j,tf);
        
    %% Estimador de estados (implemente o filtro aqui)
	xe = filtro_ekfcdnc(u,r,y,Ts);
    qe = xe(1:4,:); a = x(1:3,:);
    be = xe(5:7,:); b = x(4:6,:);

    %% Atualiza��o dos �ndices de desempenho
    for i = 1:length(ea)
    	dD = a2D(a(:,i)) * q2D(qe(:,i))';
    	ea(i) = acosd((trace(dD)-1)/2);
    end
    
    m_e = m_e + [(b-be);ea];
	sigma_be = sigma_be + [(b-be).^2;ea.^2];
	
	
end % Fim loop da simula��o MC

m_e = m_e/N;
sigma_be = sqrt(sigma_be/N - m_e.^2);

figure; hold; plot(m_e(1,:)','b'); plot(m_e(1,:)'+sigma_be(1,:)','r'); plot(m_e(1,:)'-sigma_be(1,:)','r'); title('EKF: erro bx');legend({'\mu','\sigma','-\sigma'},'Interpreter','tex'); saveas(gcf,'Resultados/Fig_erro_bx.jpg');
figure; hold; plot(m_e(2,:)','b'); plot(m_e(2,:)'+sigma_be(2,:)','r'); plot(m_e(2,:)'-sigma_be(2,:)','r'); title('EKF: erro by');legend({'\mu','\sigma','-\sigma'}); saveas(gcf,'Resultados/Fig_erro_by.jpg');
figure; hold; plot(m_e(3,:)','b'); plot(m_e(3,:)'+sigma_be(3,:)','r'); plot(m_e(3,:)'-sigma_be(3,:)','r'); title('EKF: erro bz');legend({'\mu','\sigma','-\sigma'}); saveas(gcf,'Resultados/Fig_erro_bz.jpg');
figure; hold; plot(m_e(4,:)'+sigma_be(4,:)','r'); plot(m_e(4,:)'-sigma_be(4,:)','r'); plot(m_e(4,:)','b','LineWidth',2); title('EKF: erro ang');legend({'\sigma','-\sigma','\mu'}); saveas(gcf,'Resultados/Fig_erro_ang.jpg');

close all

%filename = ['ekfcd_',num2str(N),'_',num2str(tf),'s.mat'];
%save(filename,'N','tf','x','xe','m_e','sigma_e');
