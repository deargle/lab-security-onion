#!/bin/bash
systemctl disable --now apt-daily{,-upgrade}.{timer,service}

