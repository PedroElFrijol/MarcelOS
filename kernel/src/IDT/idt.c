#include <stdint.h>
#include <string.h>

// Define a struct for the IDT entry
struct IDT_Entry {
    uint16_t base_lo; //lower 16 bits
    uint16_t selector; //base_lo + base_hi = selector (base address of the isr)
    uint8_t always0; //specifies the code segment that the isr is in (which is always 0)
    uint8_t flags; //tells the isr if its a trap or an interrupts
    uint16_t base_hi; //upper 16 bits
} __attribute__((packed)); //makes sure the struct uses less memory

// base_lo + base_hi generate a 32bit memory address

// Define a struct for the IDT pointer
struct IDTPtr {
    uint16_t limit; //the size of the idt
    uint32_t base; //base address of the idt
} __attribute__((packed));

// Define an array for the IDT entries
struct IDT_Entry idt[256];

// Declare the IDT pointer
struct IDTPtr idtp;

void set_idt_entry( //sets the values of the IDT entry at the given index (specified by "num") using the values of the other arguments passed to it.
    uint8_t num, //is an integer representing the index of an entry
    uint32_t base, //is a 32-bit integer representing the memory address of the interrupt handler function
    uint16_t sel, //is a 16-bit integer representing the segment selector used to access the interrupt handler code
    uint8_t type_attr) //is an 8-bit integer representing the type and attributes of the interrupt gate
{
    idt[num].base_lo = base & 0xFFFF; 
    idt[num].selector = sel;
    idt[num].always0 = 0;
    idt[num].flags = type_attr;
    idt[num].base_hi = (base >> 16) & 0xFFFF; //discard the 16 most significant bits of a binary number and keep only the 16 least significant bits
    //0xFFFF makes it clear that all bits in the number are set to 1
}

//INSTALL IDT