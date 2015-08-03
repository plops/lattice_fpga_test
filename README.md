[![Photography of the running FPGA.](/pcb-photo.jpg?raw=true "FPGA with LEDs being controlled by the code of this repository")](http://youtu.be/rE7uVGErM0Y)

This is how I installed the toolchain on my Gentoo system:
I wanted to make sure libftdi doesn't pull in boost.
```
echo "dev-embedded/libftdi -cxx -doc -examples python -static-libs tools" >> /etc/portage/package.use
sudo emerge mercurial confuse libftdi
git clone https://github.com/cseed/arachne-pnr
git clone https://github.com/cliffordwolf/yosys
git clone https://github.com/cliffordwolf/icestorm

# make ; make install; in each of these directories
```

The original example in arachne-pnr is using the following settings which are also documented in http://www.mouser.com/pdfdocs/EB85.PDF.
```
set_io D1 99
set_io D2 98
set_io D3 97
set_io D4 96
set_io D5 95
set_io clk 21
```


The board I have has different connections:
http://www.latticesemi.com/view_document?document_id=50373
on this board the following connections to fpga (I got this from LED_pin.pcf):
```
# Family & Device:    iCE40HX8K
# Package:            CT256
set_io LED3 A2
set_io LED7 B3
set_io clk J3
set_io LED2 B4
set_io LED4 A1
set_io LED6 C4
set_io LED8 C3
set_io LED1 B5
set_io LED5 C5
```

I set up the jumpers of the board to program the volatile RAM of the
FPGA and not the Flash.  The manual says:

```
In SPI Peripheral Mode the SPI signals loads the program file into the
CRAM (configuration ram) of the FPGA directly. In this mode the FPGA
will lose its configuration when power is removed and must be
re-configured. Jumpers must be in locations J6:1-2 and J6:3-4. Jumper
J7 is not installed. See Figure 5. LED in location D10 is connected to
the CDONE pin of the iCE40HX-8K. This can be monitored to determine
that the iCE40HX-8K is programmed correctly.
```
```
martin@labolg ~/src/fpga/arachne-pnr/examples/rot $ iceprog -S rot.bin
init..
cdone: low
reset..
cdone: low
programming..
cdone: high
Bye.
```

Video of getting a J1a cpu on the Lattice FPGA: https://www.youtube.com/watch?v=rdLgLCIDSk0