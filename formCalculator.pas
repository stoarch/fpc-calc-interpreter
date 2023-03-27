unit formCalculator;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls,
  // caculator //
  calculatorParser,
  calculatorVM;

type
  TCalculatorForm = class(TForm)
    Label1: TLabel;
    memExpression: TMemo;
    btnEvaluate: TButton;
    memResult: TMemo;
    StatusBar1: TStatusBar;
    procedure btnEvaluateClick(Sender: TObject);
  private
    { Private declarations }
    FCalculatorParser: TCalculatorParser;
    FCalculatorVM: TCalculatorVM;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent);override;
  end;

var
  CalculatorForm: TCalculatorForm;

implementation

{$R *.dfm}

procedure TCalculatorForm.btnEvaluateClick(Sender: TObject);
begin
  FCalculatorVM.Reset();
  memResult.Lines.Clear();

  if( FCalculatorParser.Evaluate(memExpression.Lines.Text) )then
  begin
    FCalculatorVM.Execute();
    memResult.Lines.Add('Result >');
    memResult.Lines.Add(FloatToStr(FCalculatorVM.Result));
  end
  else
  begin
    memResult.Lines.Add('Error of evaluation');
    memResult.Lines.Add(FCalculatorParser.ErrorMessage);
    memResult.Lines.Add(FCalculatorParser.ErrorPosition);
  end;
end;

constructor TCalculatorForm.Create(AOwner: TComponent);
begin
  inherited;

  FCalculatorParser := TCalculatorParser2.Create();
  FCalculatorVM := TCalculatorVM.Create();

  FCalculatorParser.VirtualMachine := FCalculatorVM;
end;

end.
