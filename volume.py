#!/usr/bin/python

import pulsectl
import os


def set_volume(pulse, button):
    default_sink = _get_default_sink(pulse)
    volume_info = default_sink.volume
    current_volume = volume_info.value_flat

    step = 0.05

    if button == '3':
        pulse.mute(default_sink, not default_sink.mute)
    elif button == '4':
        volume_info.value_flat = _increment_volume(current_volume, step)
        pulse.volume_set(default_sink, volume_info)
    elif button == '5':
        volume_info.value_flat = _increment_volume(current_volume, -step)
        pulse.volume_set(default_sink, volume_info)

def get_volume(pulse):
    return _get_default_sink(pulse).volume.value_flat

def _get_default_sink(pulse):
    sink_name = pulse.server_info().default_sink_name
    return pulse.get_sink_by_name(sink_name)

def _increment_volume(current_volume, increment):
    volume_with_increment = current_volume + increment

    if volume_with_increment > 1.0:
        return 1.0
    elif volume_with_increment < 0:
        return 0.0
    else:
        return volume_with_increment

button = os.environ['BLOCK_BUTTON']
p = pulsectl.Pulse()

set_volume(p, button)
print '{0:.1%}'.format(get_volume(p), button)
