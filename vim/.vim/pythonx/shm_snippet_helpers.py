import datetime
import string
import vim
import re

def remove_all_whitespace(sentence):
    sentence = re.sub(r"\s+", "", sentence, flags=re.UNICODE)
    return sentence

def remove_all_whitespace_and_punctuation(sentence):
    sentence = re.sub(r"\s+|\.|\,|\?|\!|\:|\;|\-", "", sentence, flags=re.UNICODE)
    return sentence

def getdatetime_twentyfour():
    today = datetime.datetime.now().strftime('%Y-%m-%d %H:%M')
    today = str(today)
    return today

def getdatetime_twelve():
    today = datetime.datetime.now().strftime('%Y-%m-%d %I:%M%p')
    today = str(today).lower()
    return today

def getdatetime_iso():
    today = datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S%z')
    today = str(today)
    return today

def getdate():
    today = datetime.datetime.now().strftime('%Y-%m-%d')
    today = str(today)
    return today

def gettime_twentyfour():
    now = datetime.datetime.now().strftime('%H:%M')
    now = str(now)
    return now

def gettimetwelve_():
    now = datetime.datetime.now().strftime('%I:%M%p')
    now = str(now).lower()
    return now

def high_plus_difference(low, high):
    difference = high - low
    total = high + difference
    return total

def return_uuid_four():
    uuid_four = ''
    if not snip.c:
        import uuid
        uuid_four = str(uuid.uuid4())
    return uuid_four

def _parse_comments(s):
    #from https://github.com/honza/vim-snippets/blob/62f46770378ab899f40c334de264ccd64dc2db57/pythonx/vimsnippets.py
    #""" Parses vim's comments option to extract comment format """
    i = iter(s.split(","))
    rv = []
    try:
        while True:
            # get the flags and text of a comment part
            flags, text = next(i).split(':', 1)

            if len(flags) == 0:
                rv.append(('OTHER', text, text, text, ""))
            # parse 3-part comment, but ignore those with O flag
            elif 's' in flags and 'O' not in flags:
                ctriple = ["TRIPLE"]
                indent = ""

                if flags[-1] in string.digits:
                    indent = " " * int(flags[-1])
                ctriple.append(text)

                flags, text = next(i).split(':', 1)
                assert flags[0] == 'm'
                ctriple.append(text)

                flags, text = next(i).split(':', 1)
                assert flags[0] == 'e'
                ctriple.append(text)
                ctriple.append(indent)

                rv.append(ctriple)
            elif 'b' in flags:
                if len(text) == 1:
                    rv.insert(0, ("SINGLE_CHAR", text, text, text, ""))
    except StopIteration:
        return rv

def get_comment_format():
    #from https://github.com/honza/vim-snippets/blob/62f46770378ab899f40c334de264ccd64dc2db57/pythonx/vimsnippets.py
    #""" Returns a 4-element tuple (first_line, middle_lines, end_line, indent)
    #representing the comment format for the current file.
    #It first looks at the 'commentstring', if that ends with %s, it uses that.
    #Otherwise it parses '&comments' and prefers single character comment
    #markers if there are any.
    #"""
    commentstring = vim.eval("&commentstring")
    if commentstring.endswith("%s"):
        c = commentstring[:-2]
        return (c, c, c, "")
    comments = _parse_comments(vim.eval("&comments"))
    for c in comments:
        if c[0] == "SINGLE_CHAR":
            return c[1:]
    return comments[0][1:]

def foldmarker():
    #from https://github.com/honza/vim-snippets/blob/62f46770378ab899f40c334de264ccd64dc2db57/pythonx/vimsnippets.py
    #"Return a tuple of (open fold marker, close fold marker)"
    return vim.eval("&foldmarker").split(",")
