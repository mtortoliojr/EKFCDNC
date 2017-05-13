%%--------------------------------------------------------------------------------
%% Função para o cálculo de hi(x,pGi)
%%--------------------------------------------------------------------------------
function hi = funcao_hi(x,r)

% Parâmetros físcos e do modelo
param = ler_parametros();

% Parâmetros
f		= param.fisico.f;
DCP 	= param.fisico.DCP;
rPCP 	= param.fisico.rPCP;

% Componentes q de x
q = x(1:4);

% Matriz DPG parametrizada pelo quatérnio q
DPG = q2D(q);

% --------------------------------------------------------------
% Vetor sCi
% --------------------------------------------------------------
sCi = DCP * DPG * r - DCP * rPCP;

% --------------------------------------------------------------
% Vetor hi
% --------------------------------------------------------------
hi = f * [sCi(1);sCi(2)] / sCi(3);

end
