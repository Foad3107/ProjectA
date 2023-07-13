
#include "./aes-min.h"
#include "./aes-print-block.h"

#include <string.h>
#include <stdbool.h>

void myMemCpy(void *dest, void *src, size_t n)
{
// Typecast src and dest addresses to (char *)
    char *csrc = (char *)src;
    char *cdest = (char *)dest;

// Copy contents of src[] to dest[]
    for (int i=0; i<n; i++)
        cdest[i] = csrc[i];
}

int myMemCmp(const void *s1, const void *s2, int len)
{
    unsigned char *p = s1;
    unsigned char *q = s2;
    int charCompareStatus = 0;
    //If both pointer pointing same memory block
    if (s1 == s2)
    {
        return charCompareStatus;
    }
    while (len > 0)
    {
        if (*p != *q)
        {  //compare the mismatching character
            charCompareStatus = (*p >*q)?1:-1;
            break;
        }
        len--;
        p++;
        q++;
    }
    return charCompareStatus;
}

static const uint8_t key_0[AES128_KEY_SIZE] =
{
    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
};
static const uint8_t plain_0[AES128_KEY_SIZE] =
{
    0x2f ,0x1f ,0x87 ,0xfd ,0xc1 ,0xbd ,0xb3 ,0xce ,0x1b ,0x10 ,0xec ,0x9c ,0x51 ,0x1e ,0x52 ,0xfa 
};


static bool encrypt_test(const uint8_t p_key[AES128_KEY_SIZE],
                              const uint8_t p_plain[AES_BLOCK_SIZE])
{
    uint8_t key_schedule[AES128_KEY_SCHEDULE_SIZE];
    uint8_t block[AES_BLOCK_SIZE];

    aes128_key_schedule(key_schedule, p_key);
    print_block_hex(key_schedule, AES128_KEY_SCHEDULE_SIZE);
    putchar('\n');

    myMemCpy(block, p_plain, AES_BLOCK_SIZE);
    aes128_encrypt(block, key_schedule);

    puts("Encryption done...");
    putchar('\n');
    print_block_hex(block, AES_BLOCK_SIZE);

    return 0;
}


//Adi added here
//this function sets Dummy instruction insertion on or off.
void set_dummy_instr(uint32_t on) {
  if (on) {
    __asm__ volatile("csrsi 0x7c0, 0x1c");
  } else {
    __asm__ volatile("csrci 0x7c0, 0x1c");
  }
}



int main(int argc, char **argv)
{
    bool    is_okay;

    (void)argc;
    (void)argv;
    set_dummy_instr(1);
    is_okay = encrypt_test(key_0, plain_0);
    if (!is_okay)
        return 1;
    return 0;
}
