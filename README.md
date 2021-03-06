# Texts Server

## Ingesting new texts

The `rake text_nodes:ingest` task expects a single argument: a remote git
endpoint to pull from. The expectation right now is that the repositories
contents conform to CLTK JSON, but that might change in the future. You can call
the task with a command like

```sh
rake text_nodes:ingest\[https://github.com/cltk/greek_text_perseus.git\]
```

You can, of course, replace `https://github.com/cltk/greek_text_perseus.git`
with the repository of your choice.

## Querying a text

When you fire up the server (`rails s`), a GraphiQL endpoint will be available
at `/graphql`. You can use this endpoint to try out queries and examine the
texts that are available on the server.

## License

The MIT License (MIT)

Copyright (c) 2017 CLTK

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
the Software, and to permit persons to whom the Software is furnished to do so,
subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
