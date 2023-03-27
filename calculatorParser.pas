unit calculatorParser;

interface
  uses
      calculatorVM, calculatorLexer, calculatorTokenParser,
      calculatorCompiler,
      token, tokenTypes;

type
    TCalculatorParser = class(ICalculatorParser)
      private
        FVirtualMachine: TCalculatorVM;
        FErrorPosition: string;
        FErrorMessage: string;

        FLexer: TCalculatorLexer;
        FParser: TCalculatorTokenParser;
        FCompiler: TCalculatorCompiler;

        procedure SetVirtualMachine(const Value: TCalculatorVM);

        procedure ClearAST(ast: TTokenTree);
        procedure ClearNode(node: PTokenNode);
      public
        constructor Create();
        destructor Destroy();override;

        function Evaluate(expression: string): boolean;

        property ErrorMessage: string read FErrorMessage;
        property ErrorPosition: string read FErrorPosition;

        property VirtualMachine: TCalculatorVM read FVirtualMachine write SetVirtualMachine;
      end;

implementation
  uses
    sysUtils;

{ TCalculatorParser }

constructor TCalculatorParser.Create;
begin
  FLexer := TCalculatorLexer.Create;
  FVirtualMachine := TCalculatorVM.Create;
  FParser := TCalculatorTokenParser.Create;
  FCompiler := TCalculatorCompiler.Create;
end;

destructor TCalculatorParser.Destroy;
begin
  if(Assigned(FLexer))then
    FreeAndNil(FLexer);

  if(Assigned(FVirtualMachine))then
    FreeAndNil(FVirtualMachine);

  if(Assigned(FParser))then
    FreeAndNil(FParser);

  if(Assigned(FCompiler))then
    FreeAndNil(FCompiler);

end;

function TCalculatorParser.Evaluate(expression: string): boolean;
var
  tokens: TTokenList;
  ast: TTokenTree;
begin
  //Generate lexems and tokens
  if(not FLexer.Evaluate(expression))then
  begin
    FErrorMessage := FLexer.ErrorMessage;
    FErrorPosition := FLexer.ErrorPosition;
    Result := false;
    exit;
  end;

  //Parse tokens
  tokens := FLexer.Tokens;

  if(not FParser.GenerateAST(tokens))then
  begin
    FErrorMessage := FParser.ErrorMessage;
    FErrorPosition := FParser.ErrorPosition;
    Result := false;
    exit;
  end;


  //Compile ast to vm bytecodes
  ast := FParser.AbstractSyntaxTree;

  FCompiler.VirtualMachine := VirtualMachine;
  if(not FCompiler.GenerateByteCodes(ast))then
  begin
    FErrorMessage := FCompiler.ErrorMessage;
    FErrorPosition := FCompiler.ErrorPosition;
    Result := false;
    exit;
  end;

  ClearAST(ast);

  Result := true;
end;

//Recursively clear tree and release memory
procedure TCalculatorParser.ClearAST(ast: TTokenTree);
var
  node: PTokenNode;
begin
  node := ast.root;
  if(not Assigned(node))then
  begin
    FErrorMessage := 'Abstract syntax tree can not be cleared';
    exit;
  end;

  ClearNode(node);
end;

//Recursively clear nodes and dispose them
procedure TCalculatorParser.ClearNode(node: PTokenNode);
begin
  if(not Assigned(node))then
    exit;

  ClearNode(node.Left);
  ClearNode(node.Right);

  Dispose(node);
end;

procedure TCalculatorParser.SetVirtualMachine(const Value: TCalculatorVM);
begin
  FVirtualMachine := Value;
end;

end.
