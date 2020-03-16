#!/usr/bin/env python

import sys
import time
import robot

#timestamp = time.strftime('%Y%m%d-%H%M%S')
robot.run_cli(['--outputdir', "E:\AutomationTest\output"] + sys.argv[1:])