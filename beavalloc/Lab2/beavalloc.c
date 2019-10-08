// Isaac Peters

#include <stdint.h>
#include <string.h>
#include <unistd.h>
#include <stdlib.h>
#include <errno.h>
#include <stdio.h>

#include "beavalloc.h"

#ifndef NEW_BLOCK_SIZE
    #define NEW_BLOCK_SIZE 1024
#endif

struct heap_list {
    struct heap_list* prev; 
    void* data;
    struct heap_list* next;
    uint8_t free;
    uint16_t size;
    uint16_t capacity;
    
};

// variables to store begin/end of the program memory
void* lower_mem_bound = NULL;
void* upper_mem_bound = NULL;
struct heap_list* heap = NULL;
// {
//     NULL,
//     NULL,
//     NULL,
//     TRUE,
//     0,
//     0
// };

void *beavalloc(size_t size) {
    void* mem_start = NULL;
    struct heap_list *curr = heap;
    uint8_t found_mem_spot = 0; // Did we find space?
    int new_size;

    // if size is NULL or 0, return NULL
    if (!size) {
        return NULL;
    }


    // If we don't have a lower bound we haven't started the heap; start it
    if (!heap) {
        mem_start = sbrk(NEW_BLOCK_SIZE + sizeof(struct heap_list));
        // Set heap to first pointer in linked list
        heap = mem_start;
        heap->data = mem_start + sizeof(struct heap_list);
        heap->free = 1;
        heap->capacity = NEW_BLOCK_SIZE;
        heap->size = 0;
        lower_mem_bound = mem_start;
        upper_mem_bound = lower_mem_bound + NEW_BLOCK_SIZE + sizeof(struct heap_list);
        curr = heap;
    }

    // Check to see if we have space for the amount of data we need; if we don't, make it
    while (curr != NULL && !found_mem_spot) {
        if (curr->capacity > size && curr->free) {
            // Current block has space and is free, fill it up
            curr->free = FALSE;
            curr->size = size;

            mem_start = curr->data;
            found_mem_spot = TRUE;
        }

        curr = curr->next;
    }

    // Make a new block if we didn't find one
    new_size = (((size) / NEW_BLOCK_SIZE) + 1) * NEW_BLOCK_SIZE;
    if (!found_mem_spot) {
        struct heap_list* temp = NULL;
        // {
        //     NULL,
        //     NULL,
        //     NULL,
        //     FALSE,
        //     size,
        //     new_size
        // };
        struct heap_list* last;
        // Need to allocate new memory for this
        mem_start = sbrk(new_size + sizeof(struct heap_list));
        temp = mem_start;
        mem_start += sizeof(struct heap_list);
        // Place it at the end of the heap
        curr = heap;
        while (curr) { last = curr; curr = curr->next; }
        // Initialize our temp node
        temp->prev = last;
        temp->data = mem_start;
        temp->next = NULL;
        temp->free = FALSE;
        temp->size = size;
        temp->capacity = new_size;

        last->next = temp;

        upper_mem_bound = mem_start + new_size;

    }

    return mem_start;
}

void beavfree(void *ptr) {
    struct heap_list* curr = heap;
    uint8_t found_ptr = 0;
    while (curr && !found_ptr) {
        if (curr->data == ptr) {
            found_ptr = 1;
        } else {
            curr = curr->next;
        }
    }

    if (found_ptr && curr) {
        curr->free = TRUE;
    }
    
}

void beavalloc_reset(void) {
    brk(lower_mem_bound);
    upper_mem_bound = upper_mem_bound;
    heap = NULL;
}

void beavalloc_set_verbose(uint8_t verbose) {}

void *beavcalloc(size_t nmemb, size_t size) {
    void* result = beavalloc(nmemb * size);
    memset(result, 0, nmemb*size);

    return result;
}

void *beavrealloc(void *ptr, size_t size) {
    void* result;
    struct heap_list* curr = heap;
    uint8_t found_ptr = 0;

    if (!ptr) {
        size *= 2;
        result = beavalloc(size);
        return result;
    } 
    // get the old location size
    while (curr && !found_ptr) {
        if (curr->data == ptr) {
            found_ptr = 1;
        } else {
            curr = curr->next;
        }
    }

    if (curr && found_ptr) {
        if (curr->capacity < size){
            result = beavalloc(size);
            memmove(result, ptr, curr->size);
            beavfree(ptr);
        } else {
            curr->size = size;
            result = ptr;
        }
    } else if (!found_ptr) {
        result = beavalloc(size);
    }

    return result;
}

void beavalloc_dump(uint8_t leaks_only)
{
    struct heap_list *curr = NULL;
    uint16_t i = 0;
    uint16_t leak_count = 0;
    uint16_t user_bytes = 0;
    uint16_t capacity_bytes = 0;
    uint16_t block_bytes = 0;
    uint16_t used_blocks = 0;
    uint16_t free_blocks = 0;

    if (leaks_only) {
        fprintf(stderr, "heap lost blocks\n");
    }
    else {
        fprintf(stderr, "heap map\n");
    }
    fprintf(stderr
            , "  %s\t%s\t%s\t%s\t%s" 
            "\t%s\t%s\t%s\t%s\t%s\t%s"
            "\n"
            , "blk no  "
            , "block add "
            , "next add  "
            , "prev add  "
            , "data add  "
            
            , "blk off  "
            , "dat off  "
            , "capacity "
            , "size     "
            , "blk size "
            , "status   "
        );
    for (curr = heap, i = 0; curr != NULL; curr = curr->next, i++) {
        if (leaks_only == FALSE || (leaks_only == TRUE && curr->free == FALSE)) {
            fprintf(stderr
                    , "  %u\t\t%9p\t%9p\t%9p\t%9p\t%u\t\t%u\t\t"
                      "%u\t\t%u\t\t%u\t\t%s\t%c\n"
                    , i
                    , curr
                    , curr->next
                    , curr->prev
                    , curr->data
                    , (unsigned) ((void *) curr - lower_mem_bound)
                    , (unsigned) ((void *) curr->data - lower_mem_bound)
                    , (unsigned) curr->capacity
                    , (unsigned) curr->size
                    , (unsigned) (curr->capacity + sizeof(struct heap_list))
                    , curr->free ? "free  " : "in use"
                    , curr->free ? '*' : ' '
                );
            user_bytes += curr->size;
            capacity_bytes += curr->capacity;
            block_bytes += curr->capacity + sizeof(struct heap_list);
            if (curr->free == FALSE && leaks_only == TRUE) {
                leak_count++;
            }
            if (curr->free == TRUE) {
                free_blocks++;
            }
            else {
                used_blocks++;
            }
        }
    }
    if (leaks_only) {
        if (leak_count == 0) {
            fprintf(stderr, "  *** No leaks found!!! That does NOT mean no leaks are possible. ***\n");
        }
        else {
            fprintf(stderr
                    , "  %s\t\t\t\t\t\t\t\t\t\t\t\t"
                      "%u\t\t%u\t\t%u\n"
                    , "Total bytes lost"
                    , capacity_bytes
                    , user_bytes
                    , block_bytes
                );
        }
    }
    else {
        fprintf(stderr
                , "  %s\t\t\t\t\t\t\t\t\t\t\t\t"
                "%u\t\t%u\t\t%u\n"
                , "Total bytes used"
                , capacity_bytes
                , user_bytes
                , block_bytes
            );
        fprintf(stderr, "  Used blocks: %u  Free blocks: %u  "
             "Min heap: %p    Max heap: %p\n"
               , used_blocks, free_blocks
               , lower_mem_bound, upper_mem_bound
            );
    }
}
