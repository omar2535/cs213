#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <stdint.h>
#include <sys/errno.h>
#include <assert.h>
#include "queue.h"
#include "disk.h"
#include "uthread.h"

queue_t      pending_read_queue;
unsigned int sum = 0;

void interrupt_service_routine () {
  void* val;
  void (*callback)(void*,void*);
  queue_dequeue (pending_read_queue, &val, NULL, &callback);
  callback (val, NULL);
}

void handle_read (void* resultv, void* not_used) {
  // TODO add result to sum
   sum += *((int*)resultv);
}

void handle_read_and_exit (void* resultv, void* not_used) {
  handle_read(resultv, NULL);
  printf ("%d\n", sum);
  exit (EXIT_SUCCESS);
}


int main (int argc, char** argv) {

  // Command Line Arguments
  static char* usage = "usage: aRead num_blocks";
  int num_blocks;
  char *endptr;
  if (argc == 2)
    num_blocks = strtol (argv [1], &endptr, 10);
  if (argc != 2 || *endptr != 0) {
    printf ("argument error - %s \n", usage);
    return EXIT_FAILURE;
  }

  // Initialize
  uthread_init (1);
  disk_start (interrupt_service_routine);
  pending_read_queue = queue_create();

  // Sum Blocks
  // TODO
  int result;

  for (int blockno = 0; blockno < num_blocks-1; blockno++) {
    queue_enqueue(pending_read_queue, &result, NULL, handle_read);
    disk_schedule_read (&result, blockno);   
  }
  queue_enqueue(pending_read_queue, &result, NULL, handle_read_and_exit);
  disk_schedule_read (&result, num_blocks-1); 

  
  while (1); // inifinite loop so that main doesn't return before all of the reads complete
}


