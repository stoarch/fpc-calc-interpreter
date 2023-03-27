unit numberTokenBuilder;

interface
  uses
    token, tokenBuilder;

  type
    TNumberTokenBuilder = class(TTokenBuilder)
    public
      function Execute(value: string): TToken; override;
    end;

implementation
  uses
    sysUtils, strUtils;

{ TNumberTokenBuilder }

function TNumberTokenBuilder.Execute(value: string): TToken;
var
  num : integer;
begin
  Assert(TryStrToInt(value, num), 'Not an integer');

  result.tokenType := ttNumber;
  result.valueStr := '';
  result.valueInt := num;
  result.valueReal := num;
end;

end.
