# Adjacency Matrix Generator

[![Build Status](https://travis-ci.org/petertseng-dp/adjacency-matrix.svg?branch=master)](https://travis-ci.org/petertseng-dp/adjacency-matrix)

# Notes

This was fine.
I cut corners by not checking the entire edge for validity.

Unfortunately the backslashes look ugly.
This could be avoided by putting the inputs into a non-Crystal file.

Don't forget to negate the forbidden direction when hitting a dummy node.
Otherwise you could get into an infinite loop traveling between two of them.

The work to prevent tracing each path twice is a premature optimization, but it's interesting.
Requires keeping track of which direction you just traveled from.
Make sure to do this right with dummy nodes too.

# Source

https://www.reddit.com/r/dailyprogrammer/comments/3h0uki/
