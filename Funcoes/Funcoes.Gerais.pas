unit Funcoes.Gerais;

interface

uses
  System.Classes,
  System.SysUtils,
  FMX.StdCtrls;

type
  TBotaoIndex = (biAlterar, biExcluir, biPrimeiro, biAnterior, biProximo, biUltimo, biNovo, BiGravar);
  TBotaoSet = set of TBotaoIndex;

  FuncoesGerais = class
    private

    public
      function DesabilitaBotoes(const BotaoSet: TBotaoSet;TodosOsBotoes: array[TBotaoIndex] of TButton): TBotaoSet;

  end;

implementation

{ FuncoesGerais }

function FuncoesGerais.DesabilitaBotoes(const BotaoSet: TBotaoSet;TodosOsBotoes: array[TBotaoIndex] of TButton): TBotaoSet;
var
 // TodosOsBotoes: array[TBotaoIndex] of TButton;
  Botao: TBotaoIndex;
begin
  // Mapeia os bot�es para seus �ndices correspondentes
  TodosOsBotoes[biAlterar]  := BtnAlterar;
  TodosOsBotoes[biExcluir]  := BtnExcluir;
  TodosOsBotoes[biPrimeiro] := BtnPrimeiro;
  TodosOsBotoes[biAnterior] := BtnAnterior;
  TodosOsBotoes[biProximo]  := BtnProximo;
  TodosOsBotoes[biUltimo]   := BtnUltimo;
  TodosOsBotoes[biNovo]     := BtnNovo;
  TodosOsBotoes[biGravar]   := BtnGravar;

  // Desabilita todos os bot�es
  for Botao := Low(TBotaoIndex) to High(TBotaoIndex) do
    TodosOsBotoes[Botao].Enabled := False;

  // Habilita apenas os bot�es do conjunto do par�metro
  for Botao in BotaoSet do
    TodosOsBotoes[Botao].Enabled := True;

end;

end.
