# Digital clock circuits

This folder contains a 24-hour HH:MM:SS clock, a modulo-10 counter, and a
parameterized frequency divider. Each circuit has its own testbench and
generates a simulator executable and VCD waveform in its directory.

The frequency-divider example uses `DIVIDE = 4` so its waveform is easy to
inspect. For a hardware digital clock, choose a divider value that produces
the desired one-second clock from the input clock, then connect `clk_out` to
the clock circuit's `clk` input.

To run and view a circuit, for example:

```bash
cd digital_clock/clock
iverilog -g2012 -o clock_sim clock.v clock_tb.v
vvp clock_sim
gtkwave clock.vcd
```

The PNG waveform previews are provided alongside the VCD files.
