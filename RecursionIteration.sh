#!/bin/bash
cur_dir=$(while true; do ls -R /; sleep .5; done) 
echo $cur_dir
