%%--------------------------------------------------------------------------------
%% Função para o cálculo da jacobiana de hi(x)
%%--------------------------------------------------------------------------------
function Hi = jacobiana_hi(x,r)

% Parâmetros físcos e do modelo
param = ler_parametros();

% Parâmetros
f = param.fisico.f;
DCP = param.fisico.DCP;
rPCP = param.fisico.rPCP;

% Componentes q de x
q = x(1:4);

% Matriz DPG parametrizada pelo quatérnio q
DPG = q2D(q);

% Jacobiana da matriz DPG
dDPG = jacobiana_DPG(q);

% Cálculo de sCi
sCi = DCP * DPG * r - DCP * rPCP;

% --------------------------------------------------------------
% dsCi = d(sCi)/d(q)
% dhiq = d(hi)/d(q)
% --------------------------------------------------------------
dsCi1 = (DCP * dDPG(:,1:3)) * r;
dsCi2 = (DCP * dDPG(:,4:6)) * r;
dsCi3 = (DCP * dDPG(:,7:9)) * r;
dsCi4 = (DCP * dDPG(:,10:12)) * r;
dsCi = [dsCi1, dsCi2, dsCi3, dsCi4];

dhiq = zeros(2,4);
dhiq(1,1) = [dsCi(1,1) * sCi(3) - sCi(1) * dsCi(3,1)];
dhiq(1,2) = [dsCi(1,2) * sCi(3) - sCi(1) * dsCi(3,2)];
dhiq(1,3) = [dsCi(1,3) * sCi(3) - sCi(1) * dsCi(3,3)];
dhiq(1,4) = [dsCi(1,4) * sCi(3) - sCi(1) * dsCi(3,4)];
dhiq(2,1) = [dsCi(2,1) * sCi(3) - sCi(2) * dsCi(3,1)];
dhiq(2,2) = [dsCi(2,2) * sCi(3) - sCi(2) * dsCi(3,2)];
dhiq(2,3) = [dsCi(2,3) * sCi(3) - sCi(2) * dsCi(3,3)];
dhiq(2,4) = [dsCi(2,4) * sCi(3) - sCi(2) * dsCi(3,4)];
dhiq = f * (dhiq / (sCi(3)^2));

% --------------------------------------------------------------
% dhib = d(hi)/d(b)
% --------------------------------------------------------------
dhib = zeros(2,3);

% --------------------------------------------------------------
% Jacobiana d(hi)/d(x) 
% --------------------------------------------------------------
Hi = [dhiq, dhib];

end
