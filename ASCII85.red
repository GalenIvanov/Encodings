Red [
    Title: "ASCII85 encoder and decoder"
    Author: "Galen Ivanov"
]

encode-chunk: func [b][
    b: to-integer b
    ascii: copy ""
    either zero? b [
        return "z"
    ][
        until [
            insert ascii #"!" + (b % 85)
            1 > b: b / 85    
        ]
    ]
    ascii
]

encode-ascii85: func [
    src [string! binary! block!]
][
    stream: copy src
    unless binary? stream [stream: to-binary stream]
    
    size: length? stream
    padded-size: round/ceiling/to size 4
    padding: padded-size - size
    append/dup stream 0 padding
    
    encoded: make string! padded-size * 1.25
    
    parse stream [any [copy chunk 4 skip (append encoded encode-chunk chunk)]]
    take/last/part encoded padding
    encoded
]

decode-chunk: func [str][
    n: 0
    foreach c str [n: n * 85 + (to-integer c) - 33]
    to-binary n
]


decode-ascii85: func [
    src [string!]
][
    stream: copy src
    
    size: length? stream
    padded-size: round/ceiling/to size 5
    padding: padded-size - size
    append/dup stream #"u" padding
    
    decoded: make binary! size
    
    parse stream [any [copy chunk 5 skip (append decoded decode-chunk chunk)]]
    take/last/part decoded padding
    decoded
]