unit tokenBuilder;

interface
  uses
    token
    ;

  type
    TTokenBuilder = class
    public
      function Execute(value: string): TToken; virtual;
    end;

implementation
  uses
    sysUtils
    ;

{ TTokenBuilder }

function TTokenBuilder.Execute(value: string): TToken;
begin
  raise Exception.Create('Not implemented');
end;

end.
