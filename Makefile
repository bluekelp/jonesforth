.SUFFIXES: .f .test
.PHONY: test check run run_perf_dupdrop

#BUILD_ID_NONE := -Wl,--build-id=none 
BUILD_ID_NONE := 

SHELL	:= /bin/bash

all:	jonesforth

jonesforth: jonesforth.S
	gcc -m32 -nostdlib -static $(BUILD_ID_NONE) -o $@ $<

# if compiled with OPTIMIZE_SPEED, the words in primitives.f will
# be a part of the kernel and can be omitted from below for speed
run: jonesforth
	cat primitives.f jonesforth.f $(PROG) - | ./jonesforth

clean:
	rm -f jonesforth perf_dupdrop *~ core .test_*

# Tests.

TESTS	:= $(patsubst %.f,%.test,$(wildcard test_*.f))

test check: $(TESTS)

test_%.test: test_%.f jonesforth
	@echo -n "$< ... "
	@rm -f .$@
	@cat <(echo ': TEST-MODE ;') primitives.f jonesforth.f $< <(echo 'TEST') | \
	  ./jonesforth 2>&1 | \
	  sed 's/DSP=[0-9]*//g' > .$@
	@diff -u .$@ $<.out
	@rm -f .$@
	@echo "ok"

# Performance.

perf_dupdrop: perf_dupdrop.c
	gcc -O3 -Wall -Werror -o $@ $<

run_perf_dupdrop: jonesforth
	cat <(echo ': TEST-MODE ;') primitives.f jonesforth.f perf_dupdrop.f | ./jonesforth
