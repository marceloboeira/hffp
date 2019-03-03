-- 1.
a = (fmap (+1) $ read "[1]" :: [Int]) == [2]

-- 2.
b = (fmap . fmap) (++ "lol") (Just ["Hi,", "Hello"]) == Just ["Hi,lol", "Hellolol"]

-- 3.
c = ((fmap (*2) (\x -> x - 2)) 1) == (-2)

-- 4.
d = ((fmap ((return '1' ++) . show) (\x -> [x, 1..3])) 0) == "1[0,1,2,3]"

-- 5.
e = let ioi = read "1" :: Integer
        lioi = [(show ioi)] :: [String]
        prepended = fmap ("123"++) lioi :: [String]
        changed = read (concat prepended) :: Integer
     in (((*3) changed) == 3693)

-- Check
checkAll = [a, b, c, d, e]
