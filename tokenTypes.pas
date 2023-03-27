unit tokenTypes;

interface
  uses
    token,
    system.generics.Collections
    ;

  type
    TTokenNodeType = (tnUnknown, tnExpression, tnConstant);
    TTokenList = TList<TToken>;
    TTokenStack = TStack<TToken>;

    PTokenNode = ^TTokenNode;
    TTokenNode = record
      nodeType: TTokenNodeType;
      value: TToken;
      next: PTokenNode;
      parent: PTokenNode;
      left, right: PTokenNode;
      childs: array of TTokenNode;
    end;

    //Token tree with operations specified.
    //Must be cleaned after use (traverse in depth order)
    TTokenTree = record
      root: PTokenNode;

    end;

implementation

end.
