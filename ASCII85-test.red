Red [
]

include %ASCII85.red

lorem: {Lorem ipsum dolor sit amet,
consectetur adipiscing elit,
sed do eiusmod tempor incididunt
ut labore et dolore magna aliqua.}

print to-string decode-ascii85 encode-ascii85 lorem