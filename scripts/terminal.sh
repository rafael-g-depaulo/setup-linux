#!/bin/bash

# TODO: download hyper

# set up hyper as default terminal
sudo update-alternatives --set x-terminal-emulator $(which hyper)
sudo update-alternatives --config x-terminal-emulator

