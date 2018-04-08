#!/usr/bin/python

import os

home_dir = os.environ['HOME']
disk_stats = os.statvfs(home_dir)

available_disk_in_bytes = disk_stats.f_bavail * disk_stats.f_frsize
available_disk_in_gbs = available_disk_in_bytes / (1024 * 1024 * 1024)

print "{0}G".format(available_disk_in_gbs)
