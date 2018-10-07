data Employee = Coder
              | Manager
              | Veep
              | CEO
              deriving (Eq, Ord, Show)

reportBoss :: Employee -> Employee -> IO ()
reportBoss e e' = putStrLn $ show e ++ " is the boss of " ++ show e'

employeeRank :: Employee -> Employee -> IO ()
employeeRank e e' = case compare e e' of
                      GT -> reportBoss e e'
                      EQ -> putStrLn "Neither employee\ \ is the boss"
                      LT -> (flip reportBoss) e e'
