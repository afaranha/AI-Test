#!/bin/bash

sudo dnf install tmux vim ansible-core python3 git-core make gcc -y
curl -o ~/.tmux.conf https://raw.githubusercontent.com/afaranha/AI-Test/refs/heads/main/tmux.conf
