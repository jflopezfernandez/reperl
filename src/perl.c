
#include "perl.h"

/**
 * Fatal errors are, obviously, fatal; the program does not
 * return from this function.
 */
void fatal_error(const char* error_message) {
    fprintf(stderr, "[Error]: %s\n", error_message);
    exit(EXIT_FAILURE);
}

int main(int argc, char *argv[])
{
    /**
     * Ensure the user passed in an argument.
     */
    if (argc == 1) {
        /**
         * If they didn't, print out a helpful message and
         * exit with an error status.
         */
        fatal_error("Filename(s) expected.");
    }

    /**
     * At the moment all we are doing is opening a
     * filehandle for each argument passed in.
     */
    while (*++argv) {
        /**
         * Open the filehandle as read-only.
         */
        FILE* input_file = fopen(*argv, "r");

        /**
         * For now, simply echo the file to standard output.
         */
        int current_char = NUL;

        while ((current_char = fgetc(input_file)) != EOF) {
            fputc(current_char, stdout);
        }

        /**
         * Close the filehandle.
         */
        fclose(input_file);
    }

    return EXIT_SUCCESS;
}
