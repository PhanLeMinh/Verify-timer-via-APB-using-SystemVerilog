## Timer 8-bit feature list
(The RTL code was provided by another party; I only performed verification based on their specification)

- Configure register via APB protocol (IP is APB slave).
- Support APB transfer with no wait states and no error handling. Timer can count up and down.
- Detect overflow (count reach 255) and underflow (count reach 0).
- Support polling and interrupt (can be enable or disable).
2 clocks domain: One for register configuration (pclk), Other for clock divisor (ker_clk)
- The registers include:
  - Timer Configuration Register (TCR)
  - Timer Status Register (TSR)
  - Timer Data Register (TDR)
  - Timer Interrupt Enable Register (TIE)
  - In addition, there are some descriptions of the functions of the bits in the registers, but I will not include them here.
- Block diagram
<img width="1067" height="702" alt="image" src="https://github.com/user-attachments/assets/5abda8f9-374c-4732-9810-4d985df24e12" />
