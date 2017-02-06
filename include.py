"""
A Pandoc filter for including other markdown files.
"""

from pandocfilters import toJSONFilter, Table
import logging
import json
import os

logging.basicConfig(level=logging.DEBUG)


def include(key, value, fmt, meta):
    logging.debug(key)
    if key == 'CodeBlock' and len(value) == 2:
        logging.debug(value)
        (ids, classes, key_vals), content = value
        if key_vals:
            [[k, v]] = key_vals
            if k == "include.table":
                return table(v)
            elif k == "include.text":
                return plaintext(v)


def plaintext(v):
    os.system('pandoc -t json {0} > {0}.json'.format(v))
    with open('{0}.json'.format(v), 'r+') as f:
        text_json = json.load(f)
    args = text_json['blocks']
    os.system('rm {0}.json'.format(v))
    return args


def table(v):
    os.system('pandoc -t json {0} > {0}.json'.format(v))
    with open('{0}.json'.format(v), 'r+') as f:
        table_json = json.load(f)
    arg0, arg1, arg2, arg3, arg4 = table_json['blocks'][0]['c']
    os.system('rm {0}.json'.format(v))
    return Table(arg0, arg1, arg2, arg3, arg4)


if __name__ == '__main__':
    toJSONFilter(include)
