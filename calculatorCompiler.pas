unit calculatorCompiler;

interface
  uses
    calculatorVM, token, tokenTypes;

type
  TCalculatorCompiler = class
  private
    FVirtualMachine: TCalculatorVM;
    FErrorPosition: string;
    FErrorMessage: string;
    procedure SetVirtualMachine(const Value: TCalculatorVM);
  public
    function GenerateByteCodes(ast: TTokenTree): boolean;

    property ErrorMessage: string read FErrorMessage;
    property ErrorPosition: string read FErrorPosition;

    property VirtualMachine: TCalculatorVM read FVirtualMachine write SetVirtualMachine;
  end;

implementation

{ TCalculatorCompiler }

function TCalculatorCompiler.GenerateByteCodes(ast: TTokenTree): boolean;
begin
  result := false;

  //Navigate AST from top to bottom and generate bytecodes for it
  //We use stack virtual machine, so we need to traverse tree
  //depth first
end;

procedure TCalculatorCompiler.SetVirtualMachine(const Value: TCalculatorVM);
begin
  FVirtualMachine := Value;
end;

end.
