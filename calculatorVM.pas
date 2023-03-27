unit calculatorVM;

interface
  type
      TCalculatorVM = class
      private
        FResult: real;
      public
        procedure Execute();
        procedure Reset();

        property Result: real read FResult;
      end;

implementation

{ TCalculatorVM }

procedure TCalculatorVM.Execute;
begin

end;

procedure TCalculatorVM.Reset;
begin

end;

end.
