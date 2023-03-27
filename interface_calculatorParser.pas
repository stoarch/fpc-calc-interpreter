unit interface_calculatorParser;

interface
  type
    ICalculatorParser = interface
      function Evaluate(expression: string): boolean;

      property ErrorMessage: string read FErrorMessage;
      property ErrorPosition: string read FErrorPosition;

      property VirtualMachine: TCalculatorVM read FVirtualMachine write SetVirtualMachine;
    end;

implementation

end.
