#!/usr/bin/env python

import sys
import yaml
from jinja2 import Template

if len(sys.argv) < 3:
  print "Usage: " + sys.argv[0] + " path/to/template.j2 path/to/vars.yml"
  sys.exit(2)

# Read template Jinja2 file
f = open(sys.argv[1], 'r')
template = f.read()

# Read vars/environment YAML file
vars_file = open(sys.argv[2], 'r')
myvars = yaml.load(vars_file)

# combine and print
tmpl = Template(template)
print tmpl.render(myvars)
