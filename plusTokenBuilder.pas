unit plusTokenBuilder;

interface
  uses
    token, tokenBuilder
    ;

  type
    TPlusTokenBuilder = class(TTokenBuilder)
    public
      function Execute(value: string): TToken; override;
    end;
implementation

{ TPlusTokenBuilder }

function TPlusTokenBuilder.Execute(value: string): TToken;
begin
  Assert(value = '+', 'Not an plus operator');

  Result.tokenType := ttPlus;
  Result.valueStr := value;
end;

end.
