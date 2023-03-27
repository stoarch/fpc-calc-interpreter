unit calculatorParser2;

interface
  uses
    token, tokenTypes,
    interface_calculatorParser,
    calculatorVM;

  type
    TCalculatorParser2 = class(ICalculatorParser)
    private
      FVirtualMachine: TCalculatorVM;
      FErrorPosition: string;
      FErrorMessage: string;
      FTokens: TTokenList;
      FCurToken: TToken;
      FCurTokenNo: integer;

      procedure SetVirtualMachine(const Value: TCalculatorVM);
    public
      destructor Destroy;override;

      function Evaluate(expression: string): boolean;

      property ErrorMessage: string read FErrorMessage;
      property ErrorPosition: string read FErrorPosition;

      property VirtualMachine: TCalculatorVM read FVirtualMachine write SetVirtualMachine;
    end;

implementation
  uses
    sysUtils,
    calculatorLexer;

{ TCalculatorParser2 }

destructor TCalculatorParser2.Destroy;
begin
  if(Assigned(FTokens))then
    FreeAndNil(FTokens);

  inherited;
end;

function TCalculatorParser2.Evaluate(expression: string): boolean;
var
  lexer: TCalculatorLexer;
  i : integer;
begin
  Result := false;

  //10. Make lexer for expression
  lexer := TCalculatorLexer.Create;
  if( not lexer.Evaluate(expression) ) then
  begin
    FErrorMessage := lexer.ErrorMessage;
    FErrorPosition := lexer.ErrorPosition;
    FreeAndNil(lexer);
    exit;
  end;
  FreeAndNil(lexer);

  FTokens := lexer.Tokens;

  //20. Recursively parse expression


  // result := expression | "(" expression ")"
  // expression := factor * factor | factor / factor
  // factor := term | term + term | term - term
  // term := const | expression
  // const := number {number}
  // number := [0..9]

  // So expression (1 + 3)*4 + 5
  // will be transpiled to syntax tree:
  //
  // expression
    // term  +
    //  factor  *
    //   expr     (
    //     term     +
    //       const    1
    //       const    2
    //       ) - check for bracket
    //   const  4
    // 5

  FCurTokenNo := 0;

  while (FCurTokenNo < FTokens.Count) do
  begin

  end;

  Result := true;
end;

procedure TCalculatorParser2.SetVirtualMachine(const Value: TCalculatorVM);
begin
  FVirtualMachine := Value;
end;

end.
