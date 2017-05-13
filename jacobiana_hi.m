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

% Jacobiana da matriz DPGr
dDPGr = jacobiana_DPGr(q,r);

% Cálculo de sCi
sCi = DCP * DPG * r - DCP * rPCP;

% --------------------------------------------------------------
% dsCi = d(sCi)/d(q)
% --------------------------------------------------------------
dsCi1 = (DCP * dDPGr(:,1));
dsCi2 = (DCP * dDPGr(:,2));
dsCi3 = (DCP * dDPGr(:,3));
dsCi4 = (DCP * dDPGr(:,4));
dsCi = [dsCi1, dsCi2, dsCi3, dsCi4];

% --------------------------------------------------------------
% dhiq = d(hi)/d(q)
% --------------------------------------------------------------
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
