#!/usr/bin/env bash
docker run -it -w /root --platform linux/amd64 --mount type=bind,source="$(pwd)"/tests,target=/root/tests spearw/frmatch:latest Rscript /root/tests/test-FRMatch.R