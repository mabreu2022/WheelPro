unit Funcoes.PintarJante;

interface

uses
  System.Sysutils,
  System.Classes,
  Vcl.Imaging.jpeg,
  Vcl.Graphics,
  Vcl.Imaging.pngimage,
  Math,
  Types,
  Windows;


type
  TPintarJante = class
  private

  public
    procedure ModifyPixelColors(const FileName: string; const ColorToPaint: TColor);
  end;

implementation


{ TPintarJante }

procedure TPintarJante.ModifyPixelColors(const FileName: string;
  const ColorToPaint: TColor);    //pintou tudo da cor desejada mas mata o desenho da roda
var
  Image: TPngImage;
  X, Y: Integer;
  PixelColor: TColor;
  Brush: TBrush;
begin
  // Carregar a imagem
  Image := TPngImage.Create;
  try
    Image.LoadFromFile(FileName);

    // Criar um pincel com a cor desejada
    Brush := TBrush.Create;
    try
      Brush.Color := ColorToPaint;

      // Percorrer cada pixel da imagem
      for X := 0 to Image.Width - 1 do
      begin
        for Y := 0 to Image.Height - 1 do
        begin
          // Obter a cor do pixel atual
          PixelColor := Image.Canvas.Pixels[X, Y];

          // Verificar se a cor do pixel é diferente de preto e transparente
          if (PixelColor <> clBlack) and (PixelColor <> clNone) then
          begin
            // Pintar o pixel com a cor desejada
            Image.Canvas.Pen.Color := ColorToPaint;
            Image.Canvas.Pen.Style := psSolid;
            Image.Canvas.Pen.Mode := pmCopy;
            Image.Canvas.Brush := Brush;
            Image.Canvas.Rectangle(Rect(X, Y, X + 1, Y + 1));
          end;
        end;
      end;
    finally
      Brush.Free;
    end;

    // Salvar a imagem modificada
    Image.SaveToFile(FileName+'_1');
  finally
    Image.Free;
  end;

end;

end.
