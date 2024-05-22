##Command to generate output file
CC=arm-none-eabi-gcc -mcpu=cortex-m4
LN=-T stm32f401cc_linkerscript.ld -nostdlib -Wl,-Map=file.map
##To use variable -> $(varname)
## To use dependency name inside the command -> $^
## To use target name inside the command -> $@

##target  ##depndency
main.o:main.c
	$(CC) -c $^ -o $@
	
mrcc.o:MRCC_Program.c
	$(CC) -c $^ -o $@
	
mgpio.o:MGPIO_Program.c
	$(CC) -c $^ -o $@
	
	
all:main.o mrcc.o mgpio.o

stm32f401_startupfile.o:stm32f401_startupfile.c
	$(CC) -c $^ -o $@

file.elf:
	$(CC) *.o $(LN) -o $@

symboltable.txt:
	arm-none-eabi-nm file.elf >$@

all:main.o mrcc.o mgpio.o stm32f401_startupfile.o file.elf symboltable.txt

clean:
	rm -f-r *.o file.elf file.map symboltable.txt
