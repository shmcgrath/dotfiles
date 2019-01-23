#!/bin/bash
# This script re-programs the CoolerMaster QuickFire Rapid with the
# Frosty Flake Controller
echo "Flashing QuickFire Rapid Frosty Flake in 15s..."
sleep 5
echo "Flashing QuickFire Rapid Frosty Flake in 10s..."
sleep 5
echo "Flashing QuickFire Rapid Frosty Flake in 5s..."
sleep 5
sudo dfu-programmer atmega32u2 erase
sleep 15
sudo dfu-programmer atmega32u2 flash ~/Dropbox/dotfiles/keyboard-layouts/qfr-avr.hex
sudo dfu-programmer atmega32u2 reset
