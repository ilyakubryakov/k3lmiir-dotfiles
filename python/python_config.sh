#!/bin/bash
info_msg "...Install and configure Python and modules"
#shellcheck disable=SC2154
python_req_file="https://raw.githubusercontent.com/ilyakubryakov/k3lmiir-dotfiles/$branch/python/requirements"
/bin/bash -c "$(curl "$python_req_file" --output /tmp/python_requirements)"
pip3 install -r /tmp/python_requirements
rm -rf /tmp/python_requirements