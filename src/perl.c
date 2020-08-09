/**
 *  rePerl - Minimal, Modern Perl.
 *  Copyright (C) Jose Fernando Lopez Fernandez, 2020.
 *  
 *  This program is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation, either version 3 of the License, or
 *  (at your option) any later version.
 *  
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *  
 *  You should have received a copy of the GNU General Public License
 *  along with this program.  If not, see <https://www.gnu.org/licenses/>.
 */

#include "perl.h"

/**
 * Fatal errors are, obviously, fatal; the program does not
 * return from this function.
 */
void fatal_error(const char* error_message) {
    fprintf(stderr, "[Error]: %s\n", error_message);
    exit(EXIT_FAILURE);
}

/**
 * This is the entry point of the engine. At the time of
 * writing, there are no command-line options which the
 * program will accept; it will simply interpret any and all
 * arguments as filenames to be opened, read, and compiled
 * and/or interpreted.
 *
 * @todo Implement command-line option: --help
 * @todo Implement command-line option: --version
 *
 */
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
