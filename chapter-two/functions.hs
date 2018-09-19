-- Expressions and functions
half x = x / 2
half' = flip (/) 2

square x = x * x
square' = flip (^) 2

-- circleAreaWith x = 3.14 * square x (commented in favor of using pi from Prelude)
circleAreaWith x = pi * square x
circleAreaWith' =  (* pi) . square'

-- A Head Code

-- example
mult0 = x * y
  where x = 5
        y = 6

mult1 = x * 3 + y
  where x = 5
        y = 1000

mult2 = x * 5
  where y = 10
        x = 10 * 5 + y

mult3 = z / x + y
  where x = 7
        y = negate x
        z = y * 10
