unit calculatorLexer;

interface
  uses
    token, tokenTypes, tokenBuilder,
    system.Generics.Collections;

type
    TCalculatorLexer = class
    private
      FErrorMessage: string;
      FErrorPosition: string;
      FTokenList: TTokenList;
      FTokenBuilders: TDictionary<TTokenType, TTokenBuilder>;
      procedure InitTokenBuilders;
      function GetTokenType(value: string): TTokenType;
    public
      constructor Create();
      destructor Destroy();override;

      function Evaluate(expression: String): boolean;

      property ErrorMessage: string read FErrorMessage;
      property ErrorPosition: string read FErrorPosition;

      property Tokens: TTokenList read FTokenList;
    end;

implementation
  uses
    sysutils, strUtils,
    numberTokenBuilder,
    plusTokenBuilder
    ;
{ TCalculatorLexer }

constructor TCalculatorLexer.Create;
begin
  FTokenList := TTokenList.Create;
  FTokenBuilders := TDictionary<TTokenType, TTokenBuilder>.Create;

  InitTokenBuilders();
end;

destructor TCalculatorLexer.Destroy;
begin
  if(Assigned(FTokenList))then
    FreeAndNil(FTokenList);

  if(Assigned(FTokenBuilders))then
    FreeAndNil(FTokenBuilders);

  inherited;
end;

procedure TCalculatorLexer.InitTokenBuilders();
begin
  FTokenBuilders.Add(ttNumber, TNumberTokenBuilder.Create);
  FTokenBuilders.Add(ttPlus, TPlusTokenBuilder.Create);
end;

function TCalculatorLexer.Evaluate(expression: String): boolean;
var
  tokenStrAry : TArray<String>;
  i: Integer;
  token: TToken;
  curTokenStr: String;
  curPos : integer;
  tokenType: TTokenType;
  builder : TTokenBuilder;
begin
  result := false;

  curPos := 1;

  //Split string and scan every substring to get tokens from it
  //Make list of it
  tokenStrAry := SplitString(
                   StringReplace(expression,#13#10,'',[rfReplaceAll]),
                   ' ');

  FTokenList.Clear;

  for i := 0 to Length(tokenStrAry)-1 do
  begin
    curTokenStr := UpperCase(tokenStrAry[i]);
    tokenType := GetTokenType(curTokenStr);

    if(not FTokenBuilders.ContainsKey(tokenType)) then
    begin
      FErrorMessage := Format('Unknown token %s',[curTokenStr]);
      FErrorPosition := Format('At position: %d',[curPos]);
      exit;
    end;

    builder := FTokenBuilders[tokenType];

    token.Clear;
    token := builder.Execute(curTokenStr);
    token.tokenType := tokenType;
    token.position := curPos;

    FTokenList.Add(token);

    curPos := curPos + curTokenStr.Length;
  end;

  result := true;
end;

function TCalculatorLexer.GetTokenType(value: string): TTokenType;
  var
    intRes: integer;

  function IsNumber(value: string) : boolean;
  begin
    Result := TryStrToInt(value, intRes);
  end;

  function IsPlus(value: string): boolean;
  begin
    Result := value = '+';
  end;
begin
  Result := ttUnknown;

  if( IsNumber(value) )then
  begin
    result := ttNumber;
    exit;
  end;

  if( IsPlus(value) )then
  begin
    result := ttPlus;
    exit;
  end;
end;

end.
