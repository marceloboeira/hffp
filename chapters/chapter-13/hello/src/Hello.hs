module Hello
  ( sayHello )
    where

sayHello :: IO ()
sayHello = do
  putStrLn "Hello World"
