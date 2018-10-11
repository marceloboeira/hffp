functionC x y = case x > y of
                  True -> x
                  False -> y

ifEvenAdd2 n = case even n of
                 True -> n + 2
                 False -> n

nums x = case compare x 0 of
    EQ -> 0
    LT -> -1
    GT -> 1
