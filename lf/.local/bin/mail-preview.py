#!/usr/bin/env python3

import email
import sys
import subprocess
from email import policy

path = sys.argv[1]

with open(path, "rb") as f:
    msg = email.message_from_binary_file(f, policy=policy.default)

RESET = "\033[0m"
BOLD = "\033[1m"
GREEN = "\033[32m"
YELLOW = "\033[33m"
MAGENTA = "\033[35m"
CYAN = "\033[36m"

output = []

output.append(f"{BOLD}{MAGENTA}From:{RESET}    {msg['From']}")
output.append(f"{BOLD}{YELLOW}To:{RESET}      {msg['To']}")
output.append(f"{BOLD}{CYAN}Subject:{RESET} {msg['Subject']}")
output.append(f"{BOLD}{GREEN}Date:{RESET}    {msg['Date']}")
output.append("")
output.append("========================================")
output.append("")

plain = None
html = None

if msg.is_multipart():
    for part in msg.walk():
        content_type = part.get_content_type()

        if content_type == "text/plain" and plain is None:
            plain = part.get_content()

        elif content_type == "text/html" and html is None:
            html = part.get_content()
else:
    if msg.get_content_type() == "text/plain":
        plain = msg.get_content()
    elif msg.get_content_type() == "text/html":
        html = msg.get_content()

if plain:
    output.append(plain)

elif html:
    result = subprocess.run(
        ["w3m", "-dump", "-T", "text/html"],
        input=html,
        text=True,
        capture_output=True
    )

    output.append(result.stdout)

else:
    output.append("[No readable message body]")

print("\n".join(output))
