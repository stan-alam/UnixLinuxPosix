#include "stdio.h"
#include "pthread.h"

void * callback(void * ignored)
{
	printf("Hello from a thread!\n");
	return NULL;
}

int main()
{
	printf("About to create a thread\n");
	pthread_t thread;
	if(pthread_create(&thread, NULL, callback, NULL))
	{
		fprintf(stderr, "Error creating thread\n");
		return 1;
	}

	if(pthread_join(thread, NULL))
	{
		fprintf(stderr, "Error joining thread\n");
		return 1;
	}

	printf("Thread finished\n");
	return 0;
} 
