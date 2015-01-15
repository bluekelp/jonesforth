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
        ROT     \ ( a b c -- b c a )
        ROT     \ ( b c a -- c a b )
        ;

\ ( a b -- )
: 2DROP
        DROP
        DROP
        ;

\ ( a b -- a b a b )
: 2DUP
        SWAP    \ ( a b -- b a )
        DUP     \ ( b a -- b a a )
        -ROT    \ ( b a a -- a b a )
        SWAP    \ ( a b a -- a a b )
        DUP     \ ( a a b -- a a b b )
        -ROT    \ ( a a b b -- a b a b )
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

