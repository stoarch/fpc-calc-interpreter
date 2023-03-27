unit token;

interface

type
  TTokenType = (
             ttUnknown, ttNumber, ttPlus, ttMinus, ttMultiply,
             ttDivide, ttIdentifier, ttLeftBracket, ttRightBracket,
             ttModulo, ttIntDivide, ttPower, ttUnaryMinus
             );

  TTokenPosition = type integer;

  TToken = record
    tokenType: TTokenType;

    valueStr: string;
    valueInt: integer;
    valueReal: real;

    position: TTokenPosition;

    procedure Clear;
  end;

implementation

{ TToken }

procedure TToken.Clear;
begin
  tokenType := ttUnknown;
  valueStr := '';
  valueInt := MaxInt;
  valueReal := 1e-38;
  position := -1;
end;

end.
