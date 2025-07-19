#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>
#include "lfsr.h"

void lfsr_calculate(uint16_t *reg) {
    int c = *reg;
    int z = c & 1;
    int t = (c >> 2) & 1;
    int th = (c >> 3) & 1;
    int f = (c >> 5) & 1;
    int left = z ^ t ^ th ^ f; 
    //16 bits; 
    *reg = *reg >> 1;
    if (left) {
    *reg = (*reg) | (1 << 15);
  }
}

