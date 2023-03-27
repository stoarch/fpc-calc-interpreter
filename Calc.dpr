program Calc;

uses
  Vcl.Forms,
  formCalculator in 'formCalculator.pas' {CalculatorForm},
  calculatorParser in 'calculatorParser.pas',
  calculatorVM in 'calculatorVM.pas',
  calculatorLexer in 'calculatorLexer.pas',
  calculatorTokenParser in 'calculatorTokenParser.pas',
  calculatorCompiler in 'calculatorCompiler.pas',
  token in 'token.pas',
  tokenTypes in 'tokenTypes.pas',
  tokenBuilder in 'tokenBuilder.pas',
  numberTokenBuilder in 'numberTokenBuilder.pas',
  plusTokenBuilder in 'plusTokenBuilder.pas',
  calculatorParser2 in 'calculatorParser2.pas',
  interface_calculatorParser in 'interface_calculatorParser.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TCalculatorForm, CalculatorForm);
  Application.Run;
end.
