/*
 * SPDX-License-Identifier: CC-BY-NC-SA-4.0
 *
 * Copyright (C) 2015-2022	Ed Jorgensen
 * Copyright (C) 2024		Oscar Szumiak
 *
 */

/*
 * Implement one of the C/C++ example main programs (either one).
 * Additionally, implement the assembly language stats() function example.
 * Develop a simple bash script to perform the compile, assemble, and link.
 * The link should be performed with the applicable C/C++ compiler.
 * Use the debugger as needed to debug the program. When working, execute
 * the program without the debugger and verify that the correct results
 * are displayed to the console.
 */

#include <stdio.h>

extern void stats (int[], int, int*, int*);

int
main()
{
    int lst[] = {1, -2, 3, -4, 5, 7, 9, 11};
    int len = 8;
    int sum, avg;

    stats(lst, len, &sum, &avg);

    printf("Stats:\n");
    printf("  Sum = %d \n", sum);
    printf("  Avg = %d \n", avg);

    return 0;
}

