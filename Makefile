#Change output_file_name.a below to your desired executible filename

#Set all your object files (the object files of all the .c files in your project, e.g. main.o my_sub_functions.o )
#OBJ = modbuddy.o launchpad.o soft_lcd.o soft_i2c.o
OBJ = main.o serial.o slip.o command.o write.o render.o input.o

#Set any dependant header files so that if they are edited they cause a complete re-compile (e.g. main.h some_subfunctions.h some_definitions_file.h ), or leave blank
DEPS = serial.h slip.h command.h write.h render.h input.h

#Any special libraries you are using in your project (e.g. -lbcm2835 -lrt `pkg-config --libs gtk+-3.0` ), or leave blank
INCLUDES = -lSDL2_ttf

#Set any compiler flags you want to use (e.g. -I/usr/include/somefolder `pkg-config --cflags gtk+-3.0` ), or leave blank
CFLAGS = `sdl2-config --libs --cflags` -march=native -Wall -O2 -pipe -I.

#Set the compiler you are using ( gcc for C or g++ for C++ )
CC = gcc

#Set the filename extensiton of your C files (e.g. .c or .cpp )
EXTENSION = .c

#define a rule that applies to all files ending in the .o suffix, which says that the .o file depends upon the .c version of the file and all the .h files included in the DEPS macro.  Compile each object file
%.o: %$(EXTENSION) $(DEPS)
	$(CC) -c -o $@ $< $(CFLAGS)

#Combine them into the output file
#Set your desired exe output file name here
m8c: $(OBJ)
	$(CC) -o $@ $^ $(CFLAGS) $(INCLUDES)

#Cleanup
.PHONY: clean

clean:
	rm -f *.o *~ core *~ 