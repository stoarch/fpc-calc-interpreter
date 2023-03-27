object CalculatorForm: TCalculatorForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Calculator'
  ClientHeight = 430
  ClientWidth = 450
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 85
    Height = 13
    Caption = 'Enter expression:'
  end
  object memExpression: TMemo
    Left = 8
    Top = 32
    Width = 433
    Height = 185
    Lines.Strings = (
      '1 + 2')
    TabOrder = 0
  end
  object btnEvaluate: TButton
    Left = 178
    Top = 223
    Width = 97
    Height = 41
    Caption = 'Evaluate'
    TabOrder = 1
    OnClick = btnEvaluateClick
  end
  object memResult: TMemo
    Left = 8
    Top = 272
    Width = 433
    Height = 129
    TabOrder = 2
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 411
    Width = 450
    Height = 19
    Panels = <>
  end
end
