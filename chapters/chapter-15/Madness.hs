type Verb = String
type Adjective = String
type Adverb = String
type Noun = String
type Exclamation = String

madlibbin' :: Exclamation
           -> Adverb
           -> Noun
           -> Adjective
           -> String

-- Before
-- madlibbin' e adv noun adj =
--  e <> "! he said " <> adv <> " as he jumped into his car " <> noun <> " and drove off with his " <> adj <> " wife."

-- After
madlibbin' e adv noun adj = mconcat [ e
                                    , "! she said "
                                    , adv
                                    , " as she jumped into her car "
                                    , noun
                                    , " and drove off with her "
                                    ,  adj
                                    , " wife."
                                    ]
