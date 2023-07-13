/*****************************************************************************
 * aes-print-block.h
 ****************************************************************************/

#ifndef AES_PRINT_BLOCK_H
#define AES_PRINT_BLOCK_H

/*****************************************************************************
 * Includes
 ****************************************************************************/

#include <stdint.h>
#include <stdio.h>

/*****************************************************************************
 * Inline functions
 ****************************************************************************/

static inline void print_block_hex(const uint8_t * p_block, size_t len)
{
    while (len > 1)
    {
        puthex(*p_block++);
	putchar(' ');
        len--;
    }
    if (len)
    {
        puthex(*p_block);
	putchar(' ');

    }
    putchar('\n');
}


#endif /* !defined(AES_PRINT_BLOCK_H) */
