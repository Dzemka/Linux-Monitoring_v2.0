#!/bin/bash

cat prometheus1.yml | sed "s/nodeChange/$ip/" > prometheus.yml
