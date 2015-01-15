\
\ ----------------- define standard words (usually implemented as code-words) that can easily be implemented in Forth -----------------
\                   (these can all be code-words for speed - see OPTIMIZE_SPEED in jonesforth.S)
\

\ ( a b c -- b c a )
: ROT
        >R      \ ( a b c -- a b   |   -- c )
        SWAP    \ ( a b   -- b a   | c -- c )
        R>      \ ( b a   -- b a c | c --   )
        SWAP    \ ( b a c -- b c a |   --   )
        ;

\ ( a b c -- c a b )
: -ROT
        SWAP    \ ( a b c -- a c b |   --   )
        >R      \ ( a c b -- a c   |   -- b )
        SWAP    \ ( a c   -- c a   | b -- b )
        R>      \ ( c a   -- c a b | b --   )
        ;

\ ( a b -- )
: 2DROP
        DROP
        DROP
        ;

\ ( a b -- a b a b )
: 2DUP
        OVER
        OVER
        ;

\ ( a b c d -- c d a b )
: 2SWAP
        ROT     \ ( a b c d -- a c d b |   --   )
        >R      \ ( a c d b -- a c d   |   -- b )
        ROT     \ ( a c d   -- c d a   |   --   )
        R>      \ ( c d a   -- c d a b | b --   )
        ;

\ ( a b -- (a-b) )
: -
        INVERT
        1 +
        +
        ;

: <>
        =
        INVERT
        ;

: >
        2DUP
        =
        -ROT
        <
        OR
        INVERT
        ;

: 0=
        0
        =
        ;

: 0<>
        0=
        INVERT
        ;

: <=
        2DUP
        <
        -ROT
        =
        OR
        ;

: >=
        2DUP
        >
        -ROT
        =
        OR
        ;

: 0<
        0 < ;


: 0>
        0 > ;

: 0<=
        0 <= ;

: 0>=
        0 >= ;

