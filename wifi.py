#!/usr/bin/python
# coding: utf-8

from fabric.api import local, hide
import os

device = os.environ['BLOCK_INSTANCE']

with hide('output', 'running', 'warnings'):
    status = local('nmcli -t -f GENERAL.STATE d show {0}'.format(device), capture=True)

    if "disconnected" in status:
        print "  WiFi"
    else:
        print "  WiFi"
