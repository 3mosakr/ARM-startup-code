ENTRY(Reset_Handler) /* Entry point of application to be run */

MEMORY /* Memory Discription */
{
  FLASH(rx) : ORIGIN = 0X08000000, LENGTH = 256K
  SRAM(rwx) : ORIGIN = 0X20000000, LENGTH = 20K
}

SECTIONS
{

  .text :
  {
    /*s_text = . ;  Can know from Origin of flash */ 
    *(.isr_section)
    *(.text)
    *(.rodata)
    e_text = . ;
  }>FLASH   /* >VMA AT >LMA */ /* >FLASH AT >FLASH */
  .data : 
  {
    s_data = . ;
    *(.data)
    . = ALIGN(4);
    e_data = . ;
  }>SRAM AT > FLASH
  .bss :
  {
    s_bss = . ;
    *(.bss)
    e_bss = . ;
  }>SRAM
}

