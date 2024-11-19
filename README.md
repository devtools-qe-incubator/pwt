# Overview

This project tries to simplify the execution of playwright tests on remote targets, removing the need for install all dependecies. The project is heavily influenced by https://github.com/rgl/playwright-standalone

# Usage

pwt is distributed as compressed file within all dependecies to run playwright. To install un compress and use the pwt cli inside (optional add the uncompressed folder to the path):

## Linux

```bash
mkdir /opt/pwt
tar xf  -C /opt/pwt --strip-components 1
```
