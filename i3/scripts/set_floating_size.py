#! /usr/bin/env python3

"""
    A script that resize a window when floating is enabled based on 
the window instance (first value of the WM_CLASS window property
on Xorg).

MOTIVATION: 
    i3wm configuration options have an inability to detect changes
to the current window state (fullscreen, floating) after the window
is created. After banging rocks against my head trying to re-resize
my floating terminal window when toggling floating multiple times, 
i learned about i3ipc and this cool-a** python library to script
with. Hope this is useful for someone out there.

    Used mostly to resize terminal windows when toggling floating
back and forth, but can be used with any other application that can
have its instance property modified.
"""

from argparse import ArgumentParser
from sys import maxsize
from i3ipc import Connection

parser = ArgumentParser(
    description='Resizes floating windows while toggling',
    add_help=False
)

parser.add_argument(
    'expected_instance',
    metavar='INSTANCE NAME',
)

parser.add_argument(
    '-w', '--width',
    type=int,
    default=500,
    metavar='WIDTH',
    dest='width',
)

parser.add_argument(
    '-h', '--height',
    type=int,
    default=500,
    metavar='HEIGHT',
    dest='height',
)

parser.add_argument(
    '-m', '--measurement',
    choices=['px', 'ppt'],
    default='px',
    metavar='MEASUREMENT UNIT',
    dest='measurement',
)

args = parser.parse_args()

i3 = Connection()

def resize_f_window(i3, event):
    focused = i3.get_tree().find_focused()
    instance_name = focused.window_instance
    floating_mode = focused.floating

    if (instance_name == args.expected_instance and floating_mode == 'user_on' ):
        event.container.command(f"resize set {args.width} {args.measurement} {args.height} {args.measurement}")


i3.on('window::floating', resize_f_window)
i3.main()
