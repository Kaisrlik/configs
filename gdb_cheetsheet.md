# GDB

## debuging coredump on diffeernt sysroot

    $ gdb app core -ex 'set sysroot .'

## print bt for all threads
    (gdb) thread apply all bt

## going in bt

    (gdb) frame 1

## address of the function/symbol

    (gdb) info symbol function

## disassebmle of the code

    (gdb) info symbol 0xfde09edc
    (gdb) info line *0xfde09edc
       starts at address 0xfde09ebc <blah()+356>
       and ends at 0xfde09ee4 <blah()+396>
    (gdb) disassemble /m 0xfde09edc

## show parsed structure

    $ gcc -g -c sample.c

    (gdb) add-symbol-file sample.o 0
        add symbol table from file "sample.o" at
        .text_addr = 0x0

    (gdb) p (struct sample *)0x7fffffffd6b0
        $1 = (struct sample *) 0x7fffffffd6b0
    (gdb) p *$1
        $2 = {i = 42, less = 0x7fffffffd6b0, more = 0x7fffffffd6b0}

# OpenOcd

    openocd -s ~/openocd/tcl -f tcl/interface/stlink-v2.cfg -f tcl/target/nrf51.cfg -c "init; reset halt;"
    (gdb) target remote localhost:3333
