module Razor where

data Expression = Literal Integer
                | Sum Expression Expression
                | Sub Expression Expression

eval :: Expression -> Integer
eval (Literal i) = i
eval (Sum e1 e2) = (eval e1) + (eval e2)
eval (Sub e1 e2) = (eval e1) - (eval e2)

printExpr :: Expression -> String
printExpr (Literal i) = show i
printExpr (Sum e1 e2) = "(" ++ (printExpr e1) ++ " + "  ++ (printExpr e2) ++ ")"
printExpr (Sub e1 e2) = "(" ++ (printExpr e1) ++ " - "  ++ (printExpr e2) ++ ")"
