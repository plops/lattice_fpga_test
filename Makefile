
rot.bin: rot.v rot.pcf
	yosys -q -p "synth_ice40 -blif rot.blif" rot.v
	arachne-pnr -d 8k -p rot.pcf rot.blif -o rot.txt
	icebox_explain rot.txt > rot.ex
	icepack rot.txt rot.bin

upload:
	iceprog -S rot.bin

clean:
	rm -f rot.blif rot.txt rot.ex rot.bin
