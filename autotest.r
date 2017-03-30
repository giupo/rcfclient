#!/usr/bin/env Rscript

library(testthat)
library(devtools)
library(rutils)
library(XML)

load_all()


testthat::auto_test("R", "tests/testthat/")
