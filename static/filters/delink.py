#!/usr/bin/env python

"""
Pandoc filter for removing links while keeping link text.

Ben Davies
December 2018
"""

from pandocfilters import toJSONFilter


def delink(key, value, format, meta):
    if key == "Link":
        return value[1]


toJSONFilter(delink)
