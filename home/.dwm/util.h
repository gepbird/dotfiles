/* See LICENSE file for copyright and license details. */

#define MAX(A, B)               ((A) > (B) ? (A) : (B))
#define MIN(A, B)               ((A) < (B) ? (A) : (B))
#define BETWEEN(X, A, B)        ((A) <= (X) && (X) <= (B))

#define lprint(text) { \
  FILE* fp = fopen("/tmp/dwm.log", "a"); \
  fprintf(fp, text); \
  fclose(fp); \
}
#define lprintf(text, arg0) { \
  FILE* fp = fopen("/tmp/dwm.log", "a"); \
  fprintf(fp, text, arg0); \
  fclose(fp); \
}

void die(const char *fmt, ...);
void *ecalloc(size_t nmemb, size_t size);
