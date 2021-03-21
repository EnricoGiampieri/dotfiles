#!/usr/bin/env python
"""
estrae da firefox la lista di tutti i tab e la stampa a terminale
"""
import pathlib
import json
import lz4.block
path = pathlib.Path.home().joinpath('.mozilla/firefox')
files = path.glob('*default*/sessionstore-backups/recovery.js*')
print('{"name": "tabs", "columns": ["title", "url"]}')
for f in files:
    b = f.read_bytes()
    if b[:8] == b'mozLz40\0':
        b = lz4.block.decompress(b[8:])
    j = json.loads(b)
    for w in j['windows']:
        for t in w['tabs']:
            for entry in t['entries']:
                title = entry['title']
                url = entry['url']
                data = [url, title]
                data = json.dumps(data)
                print(data)
