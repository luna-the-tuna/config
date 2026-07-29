#!/usr/bin/env bash

set -e

cog verify --file "$1"
cog check
