half x = x / 2
half' = flip (/) 2

square x = x * x
square' = flip (^) 2

-- circleAreaWith x = 3.14 * square x (commented in favor of using pi from Prelude)
piTimes = (*) pi
circleAreaWith x = pi * square x
--TODO: why this doens't work circleAreaWith' = piTimes square'
