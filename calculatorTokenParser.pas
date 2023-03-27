unit calculatorTokenParser;

interface
  uses
    token, tokenTypes
    ;

type
  TCalculatorTokenParser = class
  private
    FErrorMessage: string;
    FErrorPosition: string;
    FTokenTree: TTokenTree;
    function BuildTree(tokenStack: TTokenStack; parent: PTokenNode): PTokenNode;
  public
    //Generate abstract syntax tree for tokens
    function GenerateAST(tokens: TTokenList):boolean;

    property AbstractSyntaxTree: TTokenTree read FTokenTree;
    property ErrorMessage: string read FErrorMessage;
    property ErrorPosition: string read FErrorPosition;
  end;
implementation

{ TCalculatorTokenParser }

function TCalculatorTokenParser.GenerateAST(tokens: TTokenList): boolean;
var
  tokenStack: TTokenStack;
  root: PTokenNode;
  I: Integer;
begin
  Result := false;

  tokenStack := TTokenStack.Create;

  try
    if(tokens.Count <= 0)then
    begin
      FErrorMessage := 'No tokens to use';
      FErrorPosition := '0';
      exit;
    end;

    //Push tokens on stack in reverse order
    for I := tokens.Count - 1 downto 0 do
    begin
      tokenStack.Push(tokens[i]);
    end;

    root := BuildTree(tokenStack, nil); //no parent node present
    FTokenTree.root := root;

    Result := true;
  finally
    tokenStack.Free;
  end;
end;

function TCalculatorTokenParser.BuildTree(tokenStack: TTokenStack; parent: PTokenNode): PTokenNode;
var
  node: TTokenNode;
  token: TToken;
begin
  token := tokenStack.Pop;
  New(Result);

  Result^.parent := parent;

  //If the token is an operator, recursively build the left and right subtrees
  if((token.tokenType = ttMultiply)or(token.tokenType = ttDivide))then
  begin
    Result^.Value := token;
    Result^.nodeType := tnExpression;
    Result^.Right := BuildTree(tokenStack, Result); //we need right because of higher precedence of * over +
    Result^.Left := BuildTree(tokenStack, Result);
  end
  else if((token.tokenType = ttPlus)or(token.tokenType = ttMinus))then
  begin
    Result^.Value := token;
    Result^.nodeType := tnExpression;
    Result^.Left := BuildTree(tokenStack, Result);
    Result^.Right := BuildTree(tokenStack, Result);
  end
  else if (token.tokenType = ttNumber) then
  begin
    Result^.value := token;
    Result^.nodeType := tnConstant;
    Result^.left := nil;
    Result^.right := nil;
  end;
end;

end.
