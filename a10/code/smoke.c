#include <stdlib.h>
#include <stdio.h>
#include <assert.h>
#include <fcntl.h>
#include <unistd.h>
#include "uthread.h"
#include "uthread_mutex_cond.h"

#define NUM_ITERATIONS 1000

#ifdef VERBOSE
#define VERBOSE_PRINT(S, ...) printf (S, ##__VA_ARGS__);
#else
#define VERBOSE_PRINT(S, ...) ;
#endif

struct Agent {
  uthread_mutex_t mutex;
  uthread_cond_t  match;
  uthread_cond_t  paper;
  uthread_cond_t  tobacco;
  uthread_cond_t  smoke;
};

struct Agent* createAgent() {
  struct Agent* agent = malloc (sizeof (struct Agent));
  agent->mutex   = uthread_mutex_create();
  agent->paper   = uthread_cond_create (agent->mutex);
  agent->match   = uthread_cond_create (agent->mutex);
  agent->tobacco = uthread_cond_create (agent->mutex);
  agent->smoke   = uthread_cond_create (agent->mutex);
  return agent;
};

struct GeneralSmoker{
  struct Agent *agent;
  int match;
  int tobacco;
  int paper;
};

struct Smoker{
  struct GeneralSmoker* GeneralSmoker;
  int type;
};


struct GeneralSmoker* createGeneralSmoker(struct Agent* agent){
  struct GeneralSmoker* smoker = malloc(sizeof(struct GeneralSmoker));
  smoker->agent = agent;
  smoker->match = 0;
  smoker->tobacco = 0;
  smoker->paper = 0;
  return smoker;
};

struct Smoker *createSmoker(struct GeneralSmoker *GeneralSmoker, int type){
  struct Smoker *smoker = malloc(sizeof(struct Smoker));
  smoker->GeneralSmoker = GeneralSmoker;
  smoker->type = type;
  return smoker;
};

enum Resource            {    MATCH = 1, PAPER = 2,   TOBACCO = 4};
char* resource_name [] = {"", "match",   "paper", "", "tobacco"};

int signal_count [5];  // # of times resource signalled
int smoke_count  [5];  // # of times smoker with resource smoked

void *smoker(void *av)
{
  struct Smoker *s = av;
  struct GeneralSmoker *p = s->GeneralSmoker;
  struct Agent *a = p->agent;
  uthread_mutex_lock(a->mutex);
  while (1){
    switch(s->type){
      case PAPER:
        uthread_cond_wait(a->paper);
        if (p->match > 0 && p->tobacco > 0){
          p->match--;
          p->tobacco--;
          smoke_count[s->type]++;
          uthread_cond_signal(a->smoke);
        }
        else
          p->paper++;
        break;
        
      case MATCH:
        uthread_cond_wait(a->match);
        if (p->paper > 0 && p->tobacco > 0){
          p->tobacco--;
          p->paper--;
          smoke_count[s->type]++;
          uthread_cond_signal(a->smoke);
        }
        else
          p->match++;
        break;

      case TOBACCO:
        uthread_cond_wait(a->tobacco);
        if (p->paper > 0 && p->match > 0){
          p->match--;
          p->paper--;
          smoke_count[s->type]++;
          uthread_cond_signal(a->smoke);
        }
        else
          p->tobacco++;
        break;

      default:
        break;  
    }
    if (p->paper > 0 && p->tobacco > 0){
      uthread_cond_signal(a->match);
    }
    else if (p->paper > 0 && p->match > 0){
      uthread_cond_signal(a->tobacco);
    }
    else if (p->tobacco > 0 && p->match > 0){
      uthread_cond_signal(a->paper);
    }
  }
  uthread_mutex_unlock(a->mutex);
}

/**
 * This is the agent procedure.  It is complete and you shouldn't change it in
 * any material way.  You can re-write it if you like, but be sure that all it does
 * is choose 2 random reasources, signal their condition variables, and then wait
 * wait for a smoker to smoke.
 */
void* agent (void* av) {
  struct Agent* a = av;
  static const int choices[]         = {MATCH|PAPER, MATCH|TOBACCO, PAPER|TOBACCO};
  static const int matching_smoker[] = {TOBACCO,     PAPER,         MATCH};
  
  uthread_mutex_lock (a->mutex);
    for (int i = 0; i < NUM_ITERATIONS; i++) {
      int r = random() % 3;
      signal_count [matching_smoker [r]] ++;
      int c = choices [r];
      if (c & MATCH) {
        VERBOSE_PRINT ("match available\n");
        uthread_cond_signal (a->match);
      }
      if (c & PAPER) {
        VERBOSE_PRINT ("paper available\n");
        uthread_cond_signal (a->paper);
      }
      if (c & TOBACCO) {
        VERBOSE_PRINT ("tobacco available\n");
        uthread_cond_signal (a->tobacco);
      }
      VERBOSE_PRINT ("agent is waiting for smoker to smoke\n");
      uthread_cond_wait (a->smoke);
    }
  uthread_mutex_unlock (a->mutex);
  return NULL;
}

int main (int argc, char** argv) {
  uthread_init (7);
  struct Agent*  a = createAgent();

  struct GeneralSmoker *GeneralSmoker = createGeneralSmoker(a);
  uthread_t smoker1 = uthread_create(smoker, createSmoker(GeneralSmoker, MATCH));
  uthread_t smoker2 = uthread_create(smoker, createSmoker(GeneralSmoker, PAPER));
  uthread_t smoker3 = uthread_create(smoker, createSmoker(GeneralSmoker, TOBACCO));

  uthread_join (uthread_create (agent, a), 0);
  assert (signal_count [MATCH]   == smoke_count [MATCH]);
  assert (signal_count [PAPER]   == smoke_count [PAPER]);
  assert (signal_count [TOBACCO] == smoke_count [TOBACCO]);
  assert (smoke_count [MATCH] + smoke_count [PAPER] + smoke_count [TOBACCO] == NUM_ITERATIONS);
  printf ("Smoke counts: %d matches, %d paper, %d tobacco\n",
          smoke_count [MATCH], smoke_count [PAPER], smoke_count [TOBACCO]);
}