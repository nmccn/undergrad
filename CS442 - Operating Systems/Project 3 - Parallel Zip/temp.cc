#include <pthread.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "pzip.h"

/**
 * callbackParams{...} is a struct, used primarily for each threads parameters
 * however, it also stores a pointer to each threads local results.
 */
struct callbackParams {
	int start;
	int count;
	char *input_chars;
	int *char_frequency;
	int *entries;
	struct zipped_char *localResults;
	struct zipped_char *zipped_chars;
};

/**
 * A few global variables, mostly for the syncronization techniques for pthreads
 * but also for the zipped_char_size.
 */
pthread_barrier_t barrier;
pthread_mutex_t mutex;
int global_zipped_size;

/**
 * pzip() - zip an array of characters in parallel
 *
 * Inputs:
 * @n_threads:		   The number of threads to use in pzip
 * @input_chars:		   The input characters (a-z) to be zipped
 * @input_chars_size:	   The number of characaters in the input file
 *
 * Outputs:
 * @zipped_chars:       The array of zipped_char structs
 * @zipped_chars_count:   The total count of inserted elements into the zippedChars array.
 * @char_frequency[26]: Total number of occurences
 *
 * NOTE: All outputs are already allocated. DO NOT MALLOC or REASSIGN THEM !!!
 *
 */
void pzip(int n_threads, char *input_chars, int input_chars_size,
	  struct zipped_char *zipped_chars, int *zipped_chars_count,
	  int *char_frequency)
{
	/*
	 * An array to hold the given amount of threads, and an array of each threads corresponding
	 * callbackParams structure
	 */
	pthread_t threads[n_threads];
	struct callbackParams* param[n_threads];

	/*
	 * Create a barrier to be used to sync the threads later
	 */
	pthread_barrier_init(&barrier, NULL, n_threads);

	/*
	 * Loop to populate the array of callbackParams as well as create each thread with said parameters
	 */
	for (int i = 0; i < n_threads; i++) {
		struct callbackParams* params = malloc(sizeof(struct callbackParams));
		params->input_chars = input_chars;
		params->char_frequency = char_frequency;
		params->zipped_chars = zipped_chars;
		params->count = input_chars_size / n_threads;
		params->start = i * params->count;
		params->entries = malloc(sizeof(int));
		params->localResults = malloc(sizeof(struct zipped_char) * params->count);
		param[i] = params;

		int result = pthread_create(&threads[i], NULL, pzip_func, (void *)param[i]);

		if (result) {
			printf("Error in creating the threads!");
		}
	}

	/*
	 * Loop to call pthread_join n_threads times.
	 */
	for (int i = 0; i < n_threads; i++) {
		int result = pthread_join(threads[i], NULL);

		if (result) {
			printf("Error in joining the threads!");
		}
	}
	
	/*
	 * Copy all the data in, there has to be a better way to do this.
	 */
	for (int i = 0; i < n_threads; i++) {
		if (i == 0) {
			memcpy(&zipped_chars[0], param[i]->localResults, sizeof(struct zipped_char) * *param[i]->entries);
		}
		else {
			/*
	 		 * If not the first thread, calculate the offset to memcpy() to.
	 		 */
			int idx = 0;
			for (int j = 0; j < i; j++) {
				idx += *param[j]->entries;
			}
			memcpy(&zipped_chars[idx], param[i]->localResults, sizeof(struct zipped_char) * *param[i]->entries);
		}
	}

	/*
	 * Assign the zipped_chars_count to the newly calculated global_zipped_size. (I have to be able to do this in the thread..)
	 */
	*zipped_chars_count = global_zipped_size;

	/*
	 * Delete the barrier and return
	 */
	pthread_barrier_destroy(&barrier);
	return;
}

/**
 * pzip_func() - Routine to actually zip the characters, refered to as 'callback function'.
 * Inputs & Outputs are extracted on the first few lines of the function, but in general, the
 * entirety of the callbackParams structure is used.
 */
void *pzip_func(void *callbackParams)
{
	/*
	 * Extract all of the parameters from callbackParams
	 */
	struct callbackParams *params = callbackParams;
	int count = params->count;
	int start = params->start;
	char *input_chars = params->input_chars;
	int *char_frequency = params->char_frequency;
	int *entries = params->entries;
	struct zipped_char *localResults = params->localResults;

	/*
	 * zipped_char struct to hold a single result, these are what are added to localResults
	 */
	struct zipped_char singleResult;

	/*
	 * RLE of the designated substring
	 */
	int j = 0;

	for (int i = 0; i < count; i++) {
		int freq = 1;
		while (i < (count-1) && input_chars[start+i] == input_chars[start+i+1]) {
			freq++;
			i++;
		}
		singleResult.occurence = freq;
		singleResult.character = input_chars[start+i];
		localResults[j] = singleResult;
		j++;
	}

	/*
	 * Update both char_frequency and zipped_char_count in mutexes.
	 */
	pthread_mutex_lock(&mutex);
	for (int i = 0; i < j; i++) {
		int alphabet = localResults[i].character - 'a';
		char_frequency[alphabet] += localResults[i].occurence;
	}
	global_zipped_size += j;
	entries[0] = j;
	pthread_mutex_unlock(&mutex);

	/*
	 * Wait (to sync the threads) and then exit
	 */
	pthread_barrier_wait(&barrier);
	pthread_exit((void*) 0);
}