data BinaryTree a = Leaf | Node (BinaryTree a) a (BinaryTree a) deriving (Eq, Ord, Show)

unfold :: (a -> Maybe (a,b,a)) -> a -> BinaryTree b
unfold f d =
  case (f d) of
    Nothing -> Leaf
    Just (l, v, r) -> Node (unfold f l) v (unfold f r)

treeBuild :: Integer -> BinaryTree Integer
treeBuild n = unfold inc 0
  where inc x = if (x + 1 <= n)
                then Just (x+1, x, x+1)
                else Nothing
