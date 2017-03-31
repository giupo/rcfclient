#!/usr/bin/env Rscript

library(testthat)
library(devtools)
library(rutils)
library(XML)
library(RCurl)
library(RJSONIO)
load_all()

testthat::auto_test("R", "tests/testthat/")
