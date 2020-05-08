#!/bin/bash

set -eo pipefail

xcodebuild -workspace TFilmes.xcworkspace \
            -scheme TFilmes \
            -destination platform=iOS\ Simulator,OS=13.4.1,name=iPhone\ 11 \
            clean test