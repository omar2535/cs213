CFLAGS  += -std=gnu11 -g
UNAME = $(shell uname)
ifeq ($(UNAME), Linux)
LDFLAGS += -pthread
endif
EXES = aRead sRead tRead treasureHunt

all: $(EXES)

clean:
	rm -f *.o $(EXES); rm -rf *.dSYM
tidy:
	rm -f *.o; rm -rf *.dSYM

aRead: aRead.o disk.o queue.o uthread.o
sRead: sRead.o disk.o uthread.o
tRead: tRead.o disk.o uthread.o queue.o
tsRead: tsRead.o disk.o uthread.o uthread_mutex_cond.o queue.o
pRead: pRead.o disk.o uthread.o queue.o promise.o
treasureHunt: treasureHunt.o disk.o queue.o uthread.o

