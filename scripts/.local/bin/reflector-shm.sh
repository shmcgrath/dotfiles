#!/usr/bin/env bash

reflector \
  --save /etc/pacman.d/mirrorlist \
  --protocol https \
  --country US \
  --fastest 25 \
  --sort rate \
  --threads 4


# vim: set tw=78 ts=2 et sw=2 sr:
