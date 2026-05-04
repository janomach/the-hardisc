/*
    stubs.c — minimal bare-metal stubs for reri_sim simulation build.

    Provides printf, exit, memset and crt0/fini stubs without requiring
    any C library (newlib/picolibc), so the build works with the bare
    Ubuntu gcc-riscv64-unknown-elf toolchain.
*/

#include <stdarg.h>

#define STDOUT_REG (*(volatile int *)0x80000000u)
#define EXIT_REG   (*(volatile int *)0x80000004u)

static void _putchar(char c) { STDOUT_REG = c; }

static void _putuint(unsigned int v, unsigned int base, int upper, int width, char pad)
{
    static const char ldig[] = "0123456789abcdef";
    static const char udig[] = "0123456789ABCDEF";
    const char *digits = upper ? udig : ldig;
    char buf[32];
    int n = 0;
    if (v == 0) { buf[n++] = '0'; }
    else { while (v) { buf[n++] = digits[v % base]; v /= base; } }
    for (int i = n; i < width; i++) _putchar(pad);
    while (n--) _putchar(buf[n]);
}

int printf(const char *fmt, ...)
{
    va_list ap;
    va_start(ap, fmt);
    while (*fmt) {
        if (*fmt != '%') { _putchar(*fmt++); continue; }
        fmt++;
        char pad = ' ';
        int width = 0;
        if (*fmt == '0') { pad = '0'; fmt++; }
        while (*fmt >= '0' && *fmt <= '9') { width = width * 10 + (*fmt++ - '0'); }
        switch (*fmt++) {
            case 's': { const char *s = va_arg(ap, const char *); while (*s) _putchar(*s++); break; }
            case 'd': { int v = va_arg(ap, int); if (v < 0) { _putchar('-'); v = -v; } _putuint((unsigned)v, 10, 0, width, pad); break; }
            case 'u': { _putuint(va_arg(ap, unsigned), 10, 0, width, pad); break; }
            case 'x': { _putuint(va_arg(ap, unsigned), 16, 0, width, pad); break; }
            case 'X': { _putuint(va_arg(ap, unsigned), 16, 1, width, pad); break; }
            case '%': { _putchar('%'); break; }
            default: break;
        }
    }
    va_end(ap);
    return 0;
}

/* BSS zeroing called by crt0.S before main */
void *memset(void *s, int c, unsigned int n)
{
    unsigned char *p = s;
    while (n--)
        *p++ = (unsigned char)c;
    return s;
}

/* atexit / fini_array / init_array stubs */
int atexit(void (*fn)(void)) { (void)fn; return 0; }
void __libc_fini_array(void) {}
void __libc_init_array(void) {}

void exit(int status)
{
    EXIT_REG = status;
    while (1) {}
}

void abort(void) { while (1) {} }
