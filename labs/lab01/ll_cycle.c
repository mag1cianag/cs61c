#include <stddef.h>
#include "ll_cycle.h"

int ll_has_cycle(node *head) {
    /* your code here */
    node *tortoise = head;
    node *hare = head;
    do{
            if(hare !=NULL && hare->next != NULL && hare->next->next != NULL){
                    hare = hare->next->next;
                    tortoise = tortoise->next;
                    }else{return 0;}


            }while(tortoise != hare);
        
    return 1;
}
