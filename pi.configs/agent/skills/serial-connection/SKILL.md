---
name: serial-connection
description: Connect to and interact with serial devices (UART, USB-serial adapters, embedded systems). Supports configuration of baud rate, data bits, parity, and flow control. Use when working with serial ports, microcontrollers, or embedded devices.
---

# Serial Connection

Connect to serial devices using command-line tools with configurable parameters.

## Finding Serial Devices

List available serial ports:

manually:

```bash
# Linux
ls -l /dev/ttyUSB* /dev/ttyACM* /dev/ttyS* 2>/dev/null
```

or ask user to specify device path

## Connecting to Serial Device

### Using sterm (simplest)

```bash
# Basic connection (9600 baud, 8N1)
sterm -s 9600 /dev/ttyUSB0

# Common baud rates
sterm -s 115200 /dev/ttyUSB0
```

**To disconnect from screen:**
- press `~` then `.` - ssh using same style (detach, keeps session running)

## Common Configuration Parameters

| Parameter | Common Values | Description |
|-----------|---------------|-------------|
| Baud rate | 9600, 19200, 38400, 57600, 115200, 230400, 460800, 921600 | Speed of communication |
| Data bits | 7, 8 | Number of bits per character (usually 8) |
| Parity | none, even, odd, mark, space | Error checking (usually none) |
| Stop bits | 1, 2 | Number of stop bits (usually 1) |
| Flow control | none, hardware (RTS/CTS), software (XON/XOFF) | Usually none for simple devices |

**Default configuration (8N1):** 8 data bits, No parity, 1 stop bit

## Passing commands

Comands needs to be wrapped around with sleep, otherwise we cannot pass commands sucsefully.

Bellow there is an example sending `ls /` via serial line:

   { sleep 0.5; echo ""; sleep 0.5; echo "ls /"; sleep 1; } | timeout 4 sterm -s 115200 /dev/ttyUSB0

## Troubleshooting
