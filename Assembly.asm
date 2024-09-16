;MOHAMED KHAIRY MOHAMED ABDELRAOUF
;TP066168
;Hamada Coffee Shopp Program
;Assembly

.model small
.stack 100h
.data

    MAX_INVENTORY_ITEMS equ 40

    ;  ────────────────────────────────────────────────────────────
    ; ┊ 🚀  Inventory: ID, Name, Quantity, Price, Priority Level 🚀 ┊
    ;  ────────────────────────────────────────────────────────────

    inventory     dw 0,1,2,3,4,5,6,7,8,9
                  db "Espresso  ",  "Cappuccino", "Latte     ", "Mocha     ", "Americano ", "Macchiato ", "IcedCoffee", "ColdBrew  ", "DripCoffee", "Cortado   "
                  dw 3, 15, 8, 20, 5, 11, 7, 10, 6, 5,  8, 6, 3, 4, 9, 11, 5, 3, 4, 9, 1, 0, 1, 1, 2, 0, 1, 2, 0, 1, '$'
    

    ; Quantity & total price sold
    sales                                dw 5, 13, 17, 23, 45, 60, 70, 80, 90, 110, '$'
    individualItemPrice                  dw 8, 6, 3, 4, 9, 11, 5, 3, 4, 9, '$'
    
    totalRevenue                 dw 0
    itemIdOffset                 dw 0
    itemNameOffset               dw 20
    temQuantityOffset            dw 120
    itemPriceOffset              dw 140
    

    ;  ─────────────────
    ; ┊ 🚀  Main Menu 🚀 ┊
    ;  ─────────────────
                                     
    menu                    db 13,  '-------------< WELCOME TO HAMADA CAFE >-------------',13,10
                            db      '-----------------< NAVIGATION MENU >----------------',13, 10
                            db      '| 1. Explore Our Inventory                          |',13,10
                            db      '| 2. Add Items to Stock                             |',13,10
                            db      '| 3. Process Item Sales                             |',13,10 
                            db      '| 4. Arrange Items in Inventory                     |',13,10
                            db      '| 5. View Sales Statistics                          |',13,10
                            db      '| 0. Close Application                              |',13,10
                            db      '-----------------------------------------------------',13,10
                            db      '$'

    ;  ───────────────────
    ; ┊ 🚀  CRUD Labels 🚀 ┊
    ;  ───────────────────

    inventory_tag           db '------------------------< NOTICE >-------------------', 13, 10
                            db 'ITEMS THAT NEED REPLENISHMENT ARE MARKED IN VIVID RED'    , 13, 10
                            db '------------------------< ACTIONS >------------------', 13, 10, 10
                            db '1. Return to Home Screen'                                , 13, 10
                            db '2. Replenish Stock'                                      , 13, 10
                            db '3. Execute Item Sale'                                    , 13, 10
                            db                                                           , 13, 10
                            db 'Input your selection: $'

    inventory_title         db 13,10, '-------------< WELCOME TO HAMADA CAFE >-------------',13,10
                            db        '-----------------< OUR INVENTORY >---------------',13,10
                            db        'ID'                                               ,9
                            db        'Drink'                                            ,9,9
                            db        'In-Stock'                                         ,9
                            db        'Price RM'                                         ,13,10
                            db        '$'

    

    stock_amount dw ?
    stock_id dw ?

    ;  ────────────────────
    ; ┊ 🚀  Sell Items 🚀 ┊
    ;  ────────────────────

    item_sale_id_tag        db '--------------------------------', 13, 10
                            db 9, 9, 32, 32, 'SELL ITEM', 13, 10
                            db '--------------------------------', 13, 10
                            db 'Enter the item ID to sell: $'


    sale_quantity_tag        db 13, 10, 'Specify the number of items to sell (choose a number between 1 and 9): $'
    successful_sale          db 13, 10, 'Item has been sold successfully!', 13, 10, '$'
    sale_failure             db 13, 10, 'Item cannot be sold, not enough quantity!', 13, 10, '$'

    ;  ─────────────────────
    ; ┊ 🚀  Restock Items 🚀 ┊
    ;  ─────────────────────

   replenish_tag            db '---------------------------------' , 13, 10
                            db 9, 9, 32, 32, 'RESTOCK ITEM'        , 13, 10
                            db '---------------------------------' , 13, 10
                            db 'Select an item ID to restock: $'

    replenishment_quantity_tag       db 13, 10, 'Input the quantity for restocking (range: 1-9): $'
    replenishment_success            db 13, 10, 'Item has been restocked successfully!', 13, 10, '$'
    

    ;  ────────────────────────────
    ; ┊ 🚀  Categorize Inventory 🚀 ┊
    ;  ────────────────────────────

    order_inventory_tag      db 13, '----------------------------------------------', 13, 10
                             db 9,  'SORT INVENTORY BY STOCK COUNT'                 , 13, 10
                             db     '----------------------------------------------', 13, 10
                             db     '1. Back to Main Menu'                          , 13, 10
                             db     '2. In Stock'                                   , 13, 10
                             db     '3. Low/Out Of Stock'                           , 13, 10, 13, 10
                             db     'Enter your choice: $'

    
    ;  ────────────────────
    ; ┊ 🚀  Sales Report 🚀 ┊
    ;  ────────────────────

    sales_title             db 13,10, '-----------< WELCOME TO HAMADA CAFE >-----------',13,10
                            db        '---------------<SALES REPORT>----------------',13,10
                            db        'ID',9,'Name',9,9, 'Quantity Sold',9, 'Price/unit', 9, 'Total Earned',13,10
                            db        '$'

    sales_tag               db '-----------------------------------------------------------------', 13, 10
                            db 9,9,32,32,9,'SALES OF THE DAY'                                     , 13, 10
                            db '-----------------------------------------------------------------', 13, 10
                            db '| 1. Back to Main Menu                                           |', 13, 10
                            db '| 0. Exit the Program                                            |', 13, 10 , 13, 10
                            db 'Enter your choice: $'
                             

    ;  ─────────────────────
    ; ┊ 🚀  Miscellaneous 🚀 ┊
    ;  ─────────────────────

     user_selection                db 13, 10, 'Enter your choice: $'
     user_exit                     db 13, 10, 'Thanks for choosing HAMADA COFFEE! Eager to serve you again soon.','$'

    ;  ─────────────────────────
    ; ┊ 🚀  Syntax Formatting 🚀 ┊
    ;  ─────────────────────────

    Decor1                         db 13,10, '-----------------------------------------------' ,'$'
    Decor2                         db        '...............................................' ,'$'



;EXPLINATION
;This assembly code sets up data for a coffee shop management program.
; It starts by setting a model and stack size for the program. It then establishes data,
; such as the inventory size and details of each item in the inventory. The inventory includes details like item ID,
; name, quantity, price, and priority level. 

;Next, the program defines a series of labels and messages to be displayed in the user interface.
; These include the main menu, prompts for viewing inventory, restocking items, selling items, sorting items,
 ;and viewing sales reports. It also provides labels for error messages like invalid input.

;Additionally, the program sets up labels for the CRUD (Create, Read, Update, Delete) operations,
; such as viewing and restocking inventory, and selling items. It includes labels and messages for sales reports and 
; other miscellaneous items like user choice prompts and a closing message. 

;The use of formatting characters like '13,10' corresponds to carriage return and line feed,
; effectively creating new lines in the output, and '$' signifies the end of a string. The inventory data, labels,
; and messages are all stored in the '.data' section of the assembly code, to be used in the '.code' section,
; which is not shown in this snippet.




;=====================================================================================================================================================================================================

    ;  ────────────────────────────────────────────────────
    ; ┊ 🚀  Main User Interface Procedure (User Choices) 🚀 ┊
    ;  ────────────────────────────────────────────────────

.code
main proc

    ; Load the offset address of the data segment into AX register
    mov ax, @data
    ; Move the value in AX register to DS to set it as the data segment register
    mov ds, ax

    ; Call the draw_menu procedure to display the main menu
    call draw_menu

    ; Set AH to 01h to prepare for reading a single character from keyboard
    mov ah, 01h
    ; Interrupt 21h with AH=01h will read a character from keyboard
    int 21h

    ; Compare the character entered by user (stored in AL) with '1'
    cmp al, '1'
    ; If the character entered is '1', jump to display_inventory_screen procedure
    je display_inventory_screen
    
    
    ; Compare the character entered by user with '2'
    cmp al, '2'
    ; If the character entered is '2', jump to replenish_inventory_screen procedure
    je replenish_inventory_screen
    
    
    ; Compare the character entered by user with '3'
    cmp al, '3'
    ; If the character entered is '3', jump to inventory_sales_screen procedure
    je inventory_sales_screen

    ; Compare the character entered by user with '4'
    cmp al, '4'
    ; If the character entered is '4', jump to inventory_sorting_screen procedure
    je inventory_sorting_screen
    
    
    ; Compare the character entered by user with '5'
    cmp al, '5'
    ; If the character entered is '5', jump to sales_summary_screen procedure
    je sales_summary_screen
    
    
    ; Compare the character entered by user with '0'
    cmp al, '0'
    ; If the character entered is '0', jump to program_termination_screen procedure
    je program_termination_screen

    ; If none of the above conditions are met, jump back to main
    ; This is essentially a loop that will continue until the user enters '0' to exit
    jmp main


;EXPLINATION
;This segment of the code can be referred to as the "Main User Interface Procedure".

;In this segment, the program starts with the "main" procedure. It first sets the data segment by moving the starting address
; of the data segment into the AX register, and then moves the contents of the AX register into the Data Segment register (DS).

;The program then calls the "draw_menu" subroutine, which is responsible for displaying the menu to the user.

;After that, it uses the DOS interrupt (int 21h) with function code in AH register set to 01h to read a single character
; from the keyboard input, without echoing it to the console.

;The program then compares the character entered by the user (stored in the AL register) to various options:

;- If the user enters '1', the program jumps to the "display_inventory_screen" subroutine which handles the logic for viewing the inventory.
;- If the user enters '2', it jumps to the "replenish_inventory_screen" subroutine which handles the logic for restocking the inventory.
;- If the user enters '3', it jumps to the "inventory_sales_screen" subroutine which handles the logic for selling items.
;- If the user enters '4', it jumps to the "inventory_sorting_screen" subroutine which handles the logic for sorting the inventory.
;- If the user enters '5', it jumps to the "sales_summary_screen" subroutine which handles the logic for viewing the sales report.
;- If the user enters '0', it jumps to the "program_termination_screen" subroutine which handles the logic for exiting the program.

;If the user enters a character that does not match any of the above options, the program jumps back to the start of the "main" 
;procedure, effectively prompting the user to enter a choice again.


;=====================================================================================================================================================================================================





;  ───────────────────────────
; ┊ 🚀  INTERFACE FUNCTIONS 🚀 ┊
;  ───────────────────────────

    ;  ───────────────────────────────────────────────────────────────
    ; ┊ 🚀  Restock Inventory Interface Procedure (User Restocking) 🚀 ┊
    ;  ───────────────────────────────────────────────────────────────
        replenish_inventory_screen:
        call refresh_display        ; Clears the screen
        call inspect_inventory      ; Displays the inventory
        call replenish_inventory    ; Allows the user to restock items
        ret                         ; Returns from the procedure66

    ;  ────────────────────────────────────────────────────────────────────
    ; ┊ 🚀  Sales Inventory Interface Procedure (User Sales Interaction) 🚀 ┊
    ;  ────────────────────────────────────────────────────────────────────
   
    inventory_sales_screen:
        call refresh_display        ; Clears the screen
        call inspect_inventory      ; Displays the inventory
        call inventory_sales        ; Allows the user to sell items
        ret                         ; Returns from the procedure

    ;  ──────────────────────────────────────────────────────
    ; ┊ 🚀  Sales Report Interface Procedure (User Report) 🚀 ┊
    ;  ──────────────────────────────────────────────────────
  
    sales_summary_screen:
        call sales_summary         ; Displays the sales report
        call sales_navigation      ; Allows user navigation
        ret                        ; Returns from the procedure

    ;  ──────────────────────────────────────────────────────
    ; ┊ 🚀  View Inventory Interface Procedure (User View) 🚀 ┊
    ;  ──────────────────────────────────────────────────────
    
    display_inventory_screen:
        call refresh_display        ; Clears the screen
        call inspect_inventory      ; Displays the inventory
        call user_navigate          ; Allows user navigation
        ret                         ; Returns from the procedure

    ;  ──────────────────────────────────────────────────────
    ; ┊ 🚀  Sort Inventory Interface Procedure (User Sort) 🚀 ┊
    ;  ──────────────────────────────────────────────────────
  
    inventory_sorting_screen:
        call order_inventory      ; Sorts the inventory
        call user_navigate        ; Allows user navigation
        ret                       ; Returns from the procedure

    ;  ────────────────────────────────────────────────────
    ; ┊ 🚀  Exit Program Interface Procedure (User Exit) 🚀 ┊
    ;  ────────────────────────────────────────────────────
  
    program_termination_screen:
        call refresh_display          ; Clears the screen
        call terminate_program        ; Exits the program
        ret                           ; Returns from the procedure


;EXPLINATION
;This part of the assembly code defines different interface procedures that are related to various functionalities of your program.
; Each procedure is designed to offer a specific interface to the user. 

;1. `display_inventory_screen`: This procedure is used to display the current state of the inventory to the user.
; It first clears the screen, then calls the `inspect_inventory` procedure to print the inventory on the screen, and finally,
; it allows the user to navigate through the displayed inventory.

;2. `replenish_inventory_screen`: This procedure is used when the user wants to restock the inventory.
; It first clears the screen, then displays the current inventory. After that, it calls the `replenish_inventory`
; procedure which presumably allows the user to add more items to the inventory.

;3. `inventory_sales_screen`: This procedure is used when the user wants to interact with the inventory for sales purposes.
; It clears the screen, shows the current inventory, and then calls the `inventory_sales` procedure,
; which presumably allows the user to sell items from the inventory.

;4. `inventory_sorting_screen`: This procedure is used when the user wants to sort the items in the inventory.
; It directly calls the `order_inventory` procedure to sort the items, and then allows the user to navigate through
 ;the sorted inventory.

;5. `sales_summary_screen`: This procedure is used to display the sales report to the user. It calls the `sales_summary` 
;procedure to generate and display the report, and then allows the user to navigate through the report.

;6. `program_termination_screen`: This procedure is used when the user wants to exit the program.
;It first clears the screen and then calls the `terminate_program` procedure to stop the program.

;In each of these procedures, the `call` instruction is used to call another procedure, and `ret` is used to return back to the
; calling procedure once the called procedure has finished its execution.




;=====================================================================================================================================================================================================





;  ─────────────────────────────
; ┊ 🚀  SUBROUTINE FUNCTION 🚀 ┊
;  ─────────────────────────────

user_navigate:

    ; Load the effective address of the string "inventory_tag" into DX
    lea dx, inventory_tag
    ; Set the function number for "Output string to Console" in AH
    mov ah, 09h
    ; Interrupt 21h is DOS interrupt which invokes DOS services based on function number in AH
    int 21h

    ; Set the function number for "Read character from Console" in AH
    mov ah, 01h
    ; Interrupt 21h is DOS interrupt which invokes DOS services based on function number in AH
    int 21h

    ; Compare the input character with '0'
    cmp al, '0'
    ; If the input character is '0', jump to program_termination_screen
    je program_termination_screen

    ; Compare the input character with '1'
    cmp al, '1'
    ; If the input character is '1', jump back to the main procedure
    je main

    ; Compare the input character with '2'
    cmp al, '2'
    ; If the input character is '2', jump to replenish_inventory_screen
    je replenish_inventory_screen

    ; Compare the input character with '3'
    cmp al, '3'
    ; If the input character is '3', jump to inventory_sales_screen
    je inventory_sales_screen

    ; If no condition has been met, jump back to the main procedure
    jmp main

    ; Return from the procedure
    ret

;EXPLINATION
;This user_navigate procedure displays the inventory_tag message to the user and accepts a single character input.
; Depending on the character entered, the program navigates to different interfaces or returns to the main procedure.
; If the user enters '0', the program will exit. If the user enters '1', it will return to the main interface. 
; If '2' is entered, it will navigate to the restock inventory interface, and if '3' is entered, 
; it will navigate to the sales inventory interface. If none of these conditions are met,
; the procedure will simply return to the main interface.


;=====================================================================================================================================================================================================


;  ───────────────────────────────────────────────────────────────
; ┊ 🚀  Sales Navigation Interface Procedure (User Interaction) 🚀 ┊
;  ───────────────────────────────────────────────────────────────



sales_navigation:

    ; Load the effective address of the string "sales_tag" into DX
    lea dx, sales_tag
    ; Set the function number for "Output string to Console" in AH
    mov ah, 09h
    ; Interrupt 21h is DOS interrupt which invokes DOS services based on function number in AH
    int 21h

    ; Set the function number for "Read character from Console" in AH
    mov ah, 01h
    ; Interrupt 21h is DOS interrupt which invokes DOS services based on function number in AH
    int 21h

    ; Compare the input character with '0'
    cmp al, '0'
    ; If the input character is '0', jump to program_termination_screen
    je program_termination_screen

    ; If the input character is not '0', jump back to the main procedure
    jmp main

    ; Return from the procedure
    ret

;EXPLINATION
;The "sales_navigation" procedure is a part of the user interface that handles user input during sales operations.
; Initially, it displays the sales label, a string indicating the user is in the sales section.
; This is done by loading the address of the "sales_tag" into the DX register,
; setting the function for "Output string to Console" in AH, and triggering the DOS interrupt (21h).
; Then, it waits for user input by setting the function for "Read character from Console" in AH and again
; invoking the DOS interrupt. The user input is compared with the character '0'. If the input is '0',
; the program jumps to the "program_termination_screen" procedure, effectively ending the program. 
; If the input is any other character, control returns to the main procedure.
; The "ret" instruction signifies the end of this procedure.



;=====================================================================================================================================================================================================


;  ──────────────────────────────────────────────────────────────────────
; ┊ 🚀  Numeric Conversion and Conditional Color Assignment Procedures 🚀 ┊
;  ──────────────────────────────────────────────────────────────────────


print_int:

    ; convert the word to a string and print it
    push bx ; save BX on the stack
    mov bx, 10 ; set BX to 10 (divisor)
    xor cx, cx ; clear CX (counter)
    
    
    convert_loop:
        xor dx, dx ; clear the high byte of DX
        div bx ; divide AX by BX
        add dl, '0' ; convert the remainder to ASCII
        push dx ; save the digit on the stack
        inc cx ; increment the counter
        cmp ax, 0 ; check if AX is zero
        jne convert_loop ; if not, repeat the loop
        
        
    print_int_loop:
        pop dx ; get the next digit from the stack
        mov ah, 02 ; write character
        int 21h ; print the digit
        dec cx ; decrement the counter
        cmp cx, 0 ; check if all digits have been printed
        jne print_int_loop ; if not, repeat the loop
        pop bx ; restore BX from the stack
        ret


check_int:

    ; check if the word is less than or equal to 5
    mov bx, ax
    cmp bx, 5
    jle print_red_color
    jmp print_green_color ; jump to print_green_color if the word is greater than 5

;EXPLINATION
;This code segment involves two primary operations:
; converting a numeric value to a string for printing, and checking if the value is less than or equal to 5.
;
;1. Converting a word to a string and printing it:

;   The registers BX, CX, and DX are used for this operation. BX is set as the divisor,
;   CX is used as a counter, and DX stores the remainder of the division operation. 
;   The loop named "convert_loop" divides AX by BX (10), converts the remainder to an ASCII character,
;   and pushes it onto the stack. This process continues until AX becomes zero.
;   The "print_loop2" pops the digits from the stack and prints them one by one until all digits are printed.
;   The counter CX helps in controlling this loop. Once done, the value of BX is restored from the stack.

;2. Checking if the word is less than or equal to 5:
;
;   The register BX is used to store the value in AX for comparison.
;   If BX is less than or equal to 5, the program jumps to the label "print_red_color." If BX is greater than 5,
;   it jumps to "print_green_color." This block is used to categorize or differentiate values based on their size.




;=====================================================================================================================================================================================================

;  ───────────────────────────────────────────────────────────────
; ┊ 🚀               Print String Procedure                     🚀 ┊
;  ───────────────────────────────────────────────────────────────



print_string:
    ; Print a string of characters
    ; Input: CX = length of string, DX = offset of string
    push ax ; save registers
    push bx
    push cx
    mov bx, dx ; set BX to the offset of the string
    mov cx, 10 ; set the length to 10 characters
    print_string_loop:
        mov dl, [bx] ; load character from memory
        int 21h ; output the character
        inc bx ; increment offset to next character
        loop print_string_loop ; repeat until 10 characters are printed
    print_done:
    pop cx ; restore registers
    pop bx
    pop ax
    ret
    
    
;EXPLINATION
;This code is an assembly language subroutine called `print_string`.
; It takes a string's length and offset as inputs and prints the string character by character. 
; It uses a loop to iterate over the characters, retrieves each character from memory,
; and outputs it to the console using a DOS interrupt.
; The subroutine saves and restores registers to preserve their values,
; and it assumes a fixed string length of 10 characters. Once all characters are printed,
; the subroutine returns control to the calling code.




;=====================================================================================================================================================================================================


;  ─────────────────────────────────────────────────────────────────────────
; ┊ 🚀                 Print Red And Grenn Color Procedure                🚀 ┊
;  ─────────────────────────────────────────────────────────────────────────


print_red_color:

    ; Print a string of characters
    ; Input: CX = length of string, DX = offset of string
    
    push ax ; save registers
    push bx
    push cx
    mov bx, dx ; set BX to the offset of the string
    mov cx, 10 ; set the length to 10 characters
    
    
    print_red_loop:
        mov dl, [bx] ; load character from memory
        mov ah, 09h
        mov al, dl 
        mov bl, 04h ; set background color to black with blink
        or bl, 80h
        int 10h
        inc bx ; increment offset to next character
        loop print_red_loop ; repeat until 10 characters are printed
        
        
    print_red_done:
    pop cx ; restore registers
    pop bx
    pop ax
    ret

print_green_color:

    ; Print a string of characters
    ; Input: CX = length of string, DX = offset of string
    
    
    push ax ; save registers
    push bx
    push cx
    mov bx, dx ; set BX to the offset of the string
    mov cx, 10 ; set the length to 10 characters
    
    
    print_green_loop:
        mov dl, [bx] ; load character from memory
        mov ah, 09h
        mov al, dl
        mov bl, 02h ; set foreground color to green, background color to black without blink
        int 10h
        inc bx ; increment offset to next character
        loop print_green_loop ; repeat until 10 characters are printed
        
        
    print_green_done:
    pop cx ; restore registers
    pop bx
    pop ax
    ret

;EXPLINATION
;The first part is a subroutine called `print_red_color` that prints a string with red text color and
; a blinking black background. The second part is a subroutine called `print_green_color` 
; that prints a string with green text color and a non-blinking black background.




;=====================================================================================================================================================================================================



;  ──────────────────────
; ┊ 🚀  CRUD FUNCTIONS 🚀 ┊
;  ──────────────────────


draw_menu:

; Code to draw menu
call refresh_display  ; Calls a subroutine named "refresh_display" to clear the screen before drawing the menu

lea dx, menu       ; Loads the offset of the "menu" string into the DX register
mov ah, 09h        ; Sets AH to 09h, indicating the DOS "Write String" function
int 21h            ; Invokes the DOS interrupt 21h to display the menu string on the screen

lea dx,  user_selection  ; Loads the offset of the " user_selection" string into the DX register
mov ah, 09h          ; Sets AH to 09h, indicating the DOS "Write String" function
int 21h              ; Invokes the DOS interrupt 21h to display the " user_selection" string on the screen

ret                ; Returns control to the calling code

;EXPLINATION
; the code sets AH to 09h to indicate the DOS "Write String" function.
; The INT 21h instruction is then executed to display the " user_selection" string on the screen.

;Finally, the `ret` instruction is used to return control to the calling code, indicating the end of this procedure.

;In summary, this code snippet draws a menu on the screen by displaying the "menu" string and prompts the user for
;input by displaying the " user_selection" string. It utilizes DOS interrupt 21h to perform the string output operations.



;=====================================================================================================================================================================================================

;   ────────────────────────────────────────────────
; ┊ 🚀          View Inventory Procedure           🚀 ┊
;   ────────────────────────────────────────────────



inspect_inventory:
    ; Code to view inventory
    mov dx, offset inventory_title ; Load the offset of the inventory_title string into DX
    mov ah, 09h ; Set AH to 09h, indicating the DOS "Write String" function
    int 21h ; Invoke the DOS interrupt 21h to display the inventory_title string on the screen

    mov bp, 0 ; Initialize BP to 0
    lea si, inventory ; Load the offset of the inventory array into SI

    loop_start:
        mov ax, [si] ; Load the inventory ID into AX
        cmp ax, 10 ; Compare the inventory ID with 10 to check if it's the end of the array
        ja done ; If the ID is greater than 10, jump to done label (end of the loop)

        call print_int ; Call a subroutine named "print_int" to print the inventory ID

        call print_tab ; Call a subroutine named "print_tab" to print a tab character

        mov dx, offset inventory + 20 ; Load the offset of the inventory name into DX
        add dx, bp ; Add the value of BP to DX to point to the next word in the inventory name
        call print_string ; Call a subroutine named "print_string" to print the inventory name

        mov ax, [si + 120] ; Load the inventory stock into AX
        call check_int ; Call a subroutine named "check_int" to check if the stock is less than or equal to 5

        call print_tab ; Call a subroutine named "print_tab" to print a tab character

        mov ax, [si + 120] ; Load the inventory stock into AX
        call print_int ; Call a subroutine named "print_int" to print the inventory stock

        call print_double_tab ; Call a subroutine named "print_double_tab" to print two tab characters

        mov ax, [si + 140] ; Load the inventory price into AX
        call print_int ; Call a subroutine named "print_int" to print the inventory price

        call print_newline ; Call a subroutine named "print_newline" to print a new line character

        add bp, 10 ; Add 10 to the value of BP to move to the next inventory item
        add si, 2 ; Add 2 to SI to point to the next word in the inventory array
        jmp loop_start ; Jump back to the loop_start label to repeat the loop for the next element

    done:
    ret ; Return from the subroutine

;EXPLINATION
; This part of the code is a subroutine named `viewInventoryProcedure` that is responsible for
; displaying the inventory information. Here's a brief explanation of the code:

;- The subroutine begins by displaying the `inventory_title` string on the screen.

;- It then initializes the `bp` register to 0 and loads the offset of the `inventory` array into the `si` register.

;- Inside a loop, the subroutine retrieves the inventory ID, checks if it is the end of the array, and prints it using a 
;`printInt` subroutine.

;- It then calls a `printTab` subroutine to print a tab character.

;- Next, it retrieves the inventory name, prints it using a `printString` subroutine, and continues to retrieve and print 
;other inventory information.

;- The loop iterates over the inventory items until the end of the array is reached.

;- Finally, the subroutine ends with a `ret` instruction.

;In summary, the `viewInventoryProcedure` subroutine displays the inventory information by iterating over
; the inventory array and printing the relevant details.



;=====================================================================================================================================================================================================

;  ───────────────────────────────────────────
; ┊ 🚀      Restock Inventory Procedure     🚀 ┊
;  ───────────────────────────────────────────

replenish_inventory:
    ; Code to restock item
    lea dx, replenish_tag  ; Load the offset of the "replenish_tag" string into DX
    mov ah, 09h            ; Set AH to 09h, indicating the DOS "Write String" function
    int 21h                ; Invoke the DOS interrupt 21h to display the "replenish_tag" string on the screen

    mov ah, 01h            ; Set AH to 01h, indicating the DOS "Read Character" function
    int 21h                ; Invoke the DOS interrupt 21h to read a character from the user

    sub al, 30h            ; Convert the ASCII digit to its corresponding value
    add al, al             ; Multiply the value by 2 (since each inventory item occupies two bytes)
    sub ax, 136            ; Subtract 136 to get the offset of the selected inventory item in the inventory array
    mov stock_id, ax       ; Store the calculated offset in the "stock_id" variable

    lea dx, replenishment_quantity_tag  ; Load the offset of the "replenishment_quantity_tag" string into DX
    mov ah, 09h            ; Set AH to 09h, indicating the DOS "Write String" function
    int 21h                ; Invoke the DOS interrupt 21h to display the "replenishment_quantity_tag" string on the screen

    mov ah, 01h            ; Set AH to 01h, indicating the DOS "Read Character" function
    int 21h                ; Invoke the DOS interrupt 21h to read a character from the user

    sub al, 30h            ; Convert the ASCII digit to its corresponding value
    sub ax, 256            ; Subtract 256 to get the desired restock amount
    mov cx, ax             ; Store the restock amount in the CX register

    lea si, inventory      ; Load the offset of the "inventory" array into SI
    add si, stock_id       ; Add the "stock_id" offset to SI to point to the selected inventory item
    add cx, [si]           ; Add the restock amount to the current stock of the item
    mov word ptr [si], cx  ; Store the updated stock value in the inventory array

    call refresh_display     ; Call a subroutine named "refresh_display" to clear the screen
    call print_newline     ; Call a subroutine named "print_newline" to print a new line
    call print_asterisk    ; Call a subroutine named "print_asterisk" to print an asterisk symbol
    lea dx, replenishment_success  ; Load the offset of the "replenishment_success" string into DX
    mov ah, 09h           ; Set AH to 09h, indicating the DOS "Write String" function
    int 21h               ; Invoke the DOS interrupt 21h to display the "replenishment_success" string on the screen
    call print_asterisk    ; Call a subroutine named "print_asterisk" to print an asterisk symbol
    call print_newline     ; Call a subroutine named "print_newline" to print a new line
    call inspect_inventory    ; Call a subroutine named "inspect_inventory" to display the updated inventory
    call user_navigate     ; Call a subroutine named "user_navigate" to allow the user to navigate
    ret                    ; Return from the subroutine


;EXPLINATION
; This part of the code is a subroutine named `restockInventoryProcedure` responsible for restocking an item in the inventory.
; Here's a brief explanation of the code:

;- The subroutine displays a prompt (replenish_tag) asking the user to select an item.

;- It reads a character from the user to determine the selected item.

;- The selected item is converted from ASCII to its corresponding value and used to calculate the offset 
;of the item in the inventory array.

;- The subroutine prompts the user to enter the restock amount.

;- The restock amount is read, converted from ASCII to its corresponding value,
; and subtracted from 256 to get the desired restock quantity.

;- The current stock of the selected item is updated by adding the restock amount to it.

;- The screen is cleared, and a success message (replenishment_success) is displayed.

;- The updated inventory is displayed, and the user is allowed to navigate.

;- Finally, the subroutine returns.

;In summary, the `restockInventoryProcedure` subroutine handles the process of restocking an item in
; the inventory by interacting with the user, updating the inventory data, and providing feedback on the restocking operation.


;=====================================================================================================================================================================================================

;  ───────────────────────────────────────────────
; ┊ 🚀  Sales Processing and Feedback Procedure 🚀 ┊
;  ───────────────────────────────────────────────



inventory_sales:
    ; Code to sell an item
    lea dx, item_sale_id_tag  ; Load the offset of the "item_sale_id_tag" string into DX
    mov ah, 09h                 ; Set AH to 09h, indicating the DOS "Write String" function
    int 21h                     ; Invoke the DOS interrupt 21h to display the "item_sale_id_tag" string on the screen

    mov ah, 01h                 ; Set AH to 01h, indicating the DOS "Read Character" function
    int 21h                     ; Invoke the DOS interrupt 21h to read a character from the user

    sub al, 30h                 ; Convert the ASCII digit to its corresponding value
    add al, al                  ; Multiply the value by 2 (since each inventory item occupies two bytes)
    sub ax, 136                 ; Subtract 136 to get the offset of the selected inventory item in the inventory array
    mov stock_id, ax            ; Store the calculated offset in the "stock_id" variable

    lea dx, sale_quantity_tag  ; Load the offset of the "sale_quantity_tag" string into DX
    mov ah, 09h                 ; Set AH to 09h, indicating the DOS "Write String" function
    int 21h                     ; Invoke the DOS interrupt 21h to display the "sale_quantity_tag" string on the screen

    mov ah, 01h                 ; Set AH to 01h, indicating the DOS "Read Character" function
    int 21h                     ; Invoke the DOS interrupt 21h to read a character from the user

    sub al, 30h                 ; Convert the ASCII digit to its corresponding value
    sub ax, 256                 ; Subtract 256 to get the desired sell amount
    mov cx, ax                  ; Store the sell amount in the CX register

    lea si, inventory           ; Load the offset of the "inventory" array into SI
    add si, stock_id            ; Add the "stock_id" offset to SI to point to the selected inventory item
    mov bx, [si]                ; Load the current stock into BX
    sub bx, cx                  ; Subtract the sell amount from the current stock

    cmp bx, 0                   ; Compare the updated stock with zero
    js reset_quantity           ; If the stock is negative, jump to the "reset_quantity" label

    mov word ptr [si], bx       ; Store the updated stock value in the inventory array
    jmp sold_quantity           ; Jump to the "sold_quantity" label

reset_quantity:
    ; Reset the quantity of the item
    mov bx, [si]                ; Load the original stock value from memory into BX
    mov word ptr [si], bx       ; Store the original stock value back in the inventory array

    call refresh_display        ; Call a subroutine named "refresh_display" to clear the screen
    call print_newline          ; Call a subroutine named "print_newline" to print a new line
    call print_asterisk         ; Call a subroutine named "print_asterisk" to print an asterisk symbol
    lea dx, sale_failure        ; Load the offset of the "sale_failure" string into DX
    mov ah, 09h                 ; Set AH to 09h, indicating the DOS "Write String" function
    int 21h                     ; Invoke the DOS interrupt 21h to display the "sale_failure" string on the screen
    call print_asterisk         ; Call a subroutine named "print_asterisk" to print an asterisk symbol
    call print_newline          ; Call a subroutine named "print_newline" to print a new line
    call inspect_inventory         ; Call a subroutine named "inspect_inventory" to display the updated inventory
    call user_navigate          ; Call a subroutine named "user_navigate" to allow the user to navigate
    ret                         ; Return from the subroutine

    

sold_quantity:
    call sales_done           ; Call a subroutine named "sales_done" to finalize the sales process
    call refresh_display      ; Call a subroutine named "refresh_display" to clear the screen
    call print_newline        ; Call a subroutine named "print_newline" to print a new line
    call print_asterisk       ; Call a subroutine named "print_asterisk" to print an asterisk symbol
    lea dx, successful_sale   ; Load the offset of the "successful_sale" string into DX
    mov ah, 09h               ; Set AH to 09h, indicating the DOS "Write String" function
    int 21h                   ; Invoke the DOS interrupt 21h to display the "successful_sale" string on the screen
    call print_asterisk       ; Call a subroutine named "print_asterisk" to print an asterisk symbol
    call print_newline         ; Call a subroutine named "print_newline" to print a new line
    call inspect_inventory     ; Call a subroutine named "inspect_inventory" to display the updated inventory
    call user_navigate         ; Call a subroutine named "user_navigate" to allow the user to navigate
    ret                        ; Return from the subroutine

sales_done:
    mov ax, stock_id        ; Move the stock_id into the AX register
    sub ax, 120             ; Subtract 120 to adjust the offset for the "sales" array
    mov stock_id, ax        ; Store the adjusted stock_id in the stock_id variable
    lea si, sales           ; Load the offset of the "sales" array into SI
    add si, stock_id        ; Add the stock_id offset to SI to point to the selected sales item
    mov ax, [si]            ; Load the current sales quantity into AX
    add cx, ax              ; Add the sell quantity to the current sales quantity
    mov word ptr [si], cx   ; Store the updated sales quantity in the sales array
    ret                     ; Return from the subroutine

;EXPLINATION
;This section, which we can call "Sales Processing and Feedback Procedure",
; manages the selling process in the inventory system. It begins by asking the user for item details to be sold,
; validates the request, and updates the inventory and sales records. If the user tries to sell more 
; items than available, the system will handle this by resetting the quantity. Feedback is provided to
; the user depending on the success or failure of the operation.



;=====================================================================================================================================================================================================



    ;  ─────────────────────────────────────────────
    ; ┊ 🚀  Inventory Sorting Interface Procedure 🚀 ┊
    ;  ─────────────────────────────────────────────

order_inventory:
    ; Clear the screen
    call refresh_display
    
    
    ; Load the effective address of the string "order_inventory_tag" into DX
    lea dx, order_inventory_tag
    
    
    ; Set the function number for "Output string to Console" in AH
    mov ah, 09h
    ; Interrupt 21h is DOS interrupt which invokes DOS services based on function number in AH
    int 21h 

    ; Set the function number for "Read character from Console" in AH
    mov ah, 01h 
    ; Interrupt 21h is DOS interrupt which invokes DOS services based on function number in AH
    int 21h 
    
    
    ; Compare the input character with '2'
    cmp al, '2'
    ; If the input character is '2', jump to in_stock_prompt
    je in_stock_prompt
    
    
    ; Compare the input character with '3'
    cmp al, '3' 
    ; If the input character is '3', jump to low_in_stock_prompt
    je low_in_stock_prompt 
    
    
    ; Compare the input character with '1'
    cmp al, '1'
    ; If the input character is '1', call the main procedure
    call main

    ; Return from the procedure
    ret
    
    
;EXPLINATION
;The procedure provides an interface to sort inventory based on user input.
; It prompts the user for a sorting method, reads the user's choice, and then sorts the inventory based on the user's choice.
; It jumps to different segments of the code depending on the user's choice.
; It clears the screen before showing any output to make sure the output is easily readable.




;=====================================================================================================================================================================================================




    ;  ────────────────────────────────────────────
    ; ┊ 🚀  In-Stock Inventory Display Procedure 🚀 ┊
    ;  ────────────────────────────────────────────

in_stock_prompt:
    ; Clear the screen
    call refresh_display

    ; Load the effective address of the string "inventory_title" into DX
    mov dx, offset inventory_title
    
    ; Set the function number for "Output string to Console" in AH
    mov ah, 09
    ; Interrupt 21h is DOS interrupt which invokes DOS services based on function number in AH
    int 21h
    
    ; Initialize BP register to 0
    mov bp, 0
    ; Load the effective address of "inventory" into SI
    lea si, inventory
    
    ; Start of the loop to print inventory items
    loop_start2:
        ; Load inventory quantity into AX
        mov ax, [si]
        ; Compare inventory quantity with 10
        cmp ax, 10
        ; If the quantity is greater than 10, jump to the end of the procedure
        ja end2

        ; Load inventory id into AX
        mov ax, [si + 120]
        ; Check if end of array
        cmp ax, 6
        ; If the id is less than 6, jump to done2
        jl done2 

        ; Print the inventory id
        mov ax, [si]
        call print_int

        ; Print a tab space
        call print_tab

        ; Load inventory name into DX
        mov dx, offset inventory + 20
        ; Add BP to DX to point to the next word
        add dx, bp
        ; Print the inventory name
        call print_string
        ; Load inventory stock into AX
        mov ax, [si + 120]
        ; Check if stock is less than or equal to 5
        call check_int

        ; Print a tab space
        call print_tab

        ; Print inventory stock
        mov ax, [si + 120]
        call print_int

        ; Print double tab space
        call print_double_tab

        ; Print inventory sales
        mov ax, [si + 140]
        call print_int
        ; Print a newline
        call print_newline

        ; Increment BP by 10 to point to the next word
        add bp, 10
        ; Increment SI by 2 to point to the next word
        add si, 2
        ; Repeat the loop for the next element
        jmp loop_start2
    
    done2:
        ; Increment BP by 10 to point to the next word
        add bp, 10
        ; Increment SI by 2 to point to the next word
        add si, 2
        ; Repeat the loop for the next element
        jmp loop_start2

    ; End of the procedure
    end2:
        ret

;EXPLINATION
;This procedure is used to display all the items in the inventory that have a stock level greater than 10.
;It reads the data from the inventory array and outputs it in a structured format. 
;For each item, it prints the item's id, name, stock level, and sales amount.
; It uses several helper procedures to print integers, strings, tabs, and newlines.



;=====================================================================================================================================================================================================





    ; ──────────────────────────────────────────────────────
    ; ┊ 🚀  Low Stock Inventory Display Procedure 🚀 ┊
    ; ──────────────────────────────────────────────────────

low_in_stock_prompt:
    ; Clear the screen
    call refresh_display

    ; Load the effective address of the string "inventory_title" into DX
    mov dx, offset inventory_title
    
    ; Set the function number for "Output string to Console" in AH
    mov ah, 09
    ; Interrupt 21h is DOS interrupt which invokes DOS services based on function number in AH
    int 21h
    
    ; Initialize BP register to 0
    mov bp, 0
    ; Load the effective address of "inventory" into SI
    lea si, inventory
    
    ; Start of the loop to print inventory items
    loop_start3:
        ; Load inventory quantity into AX
        mov ax, [si]
        ; Compare inventory quantity with 10
        cmp ax, 10
        ; If the quantity is greater than 10, jump to the end of the procedure
        ja end3

        ; Load inventory id into AX
        mov ax, [si + 120]
        ; Check if end of array
        cmp ax, 5
        ; If the id is more than 5, jump to done3
        jg done3 

        ; Print the inventory id
        mov ax, [si]
        call print_int

        ; Print a tab space
        call print_tab

        ; Load inventory name into DX
        mov dx, offset inventory + 20
        ; Add BP to DX to point to the next word
        add dx, bp
        ; Print the inventory name
        call print_string
        ; Load inventory stock into AX
        mov ax, [si + 120]
        ; Check if stock is less than or equal to 5
        call check_int

        ; Print a tab space
        call print_tab

        ; Print inventory stock
        mov ax, [si + 120]
        call print_int

        ; Print double tab space
        call print_double_tab

        ; Print inventory sales
        mov ax, [si + 140]
        call print_int
        ; Print a newline
        call print_newline

        ; Increment BP by 10 to point to the next word
        add bp, 10
        ; Increment SI by 2 to point to the next word
        add si, 2
        ; Repeat the loop for the next element
        jmp loop_start3
    
    done3:
        ; Increment BP by 10 to point to the next word
        add bp, 10
        ; Increment SI by 2 to point to the next word
        add si, 2
        ; Repeat the loop for the next element
        jmp loop_start3

    ; End of the procedure
    end3:
        ret

;EXPLINATION
;This procedure is used to display all the items in the inventory that have a stock level of 5 or less. 
;It reads the data from the inventory array and outputs it in a structured format. For each item,
; it prints the item's id, name, stock level, and sales amount. It uses several helper procedures to print integers,
; strings, tabs, and newlines.




;=====================================================================================================================================================================================================



    ;  ──────────────────────────────────────────
    ; ┊ 🚀  Sales Report Generation Procedure 🚀 ┊
    ;  ─────────────────────────────────────────
    
sales_summary:
    ; Clear the screen
    call refresh_display
    
    ; Load the effective address of the string "sales_title" into DX
    mov dx, offset sales_title
    ; Set the function number for "Output string to Console" in AH
    mov ah, 09
    ; Interrupt 21h is DOS interrupt which invokes DOS services based on function number in AH
    int 21h

    ; Initialize BP register to 0
    mov bp, 0
    ; Load the effective address of "inventory" into SI
    lea si, inventory
    ; Load the effective address of "sales" into BX
    mov bx, offset sales 
    ; Load the effective address of "individualItemPrice" into DI
    mov di, offset individualItemPrice 

    ; Start of the loop to print sales report
    loop_start5:
        ; Load inventory id into AX
        mov ax, [si]
        ; Compare inventory id with 10
        cmp ax, 10
        ; If the id is greater than 10, jump to the end of the procedure
        ja done5
        ; Print the inventory id
        call print_int

        ; Print a tab space
        call print_tab

        ; Load inventory name into DX
        mov dx, offset inventory + 20
        ; Add BP to DX to point to the next word
        add dx, bp
        ; Print the inventory name
        call print_string

        ; Print a tab space
        call print_tab

        ; Print sales quantity
        mov ax, [bx]
        call print_int

        ; Print double tab space
        call print_double_tab
    
        ; Print inventory sales
        mov ax, [si + 140]
        call print_int
    
        ; Print double tab space
        call print_double_tab

        ; Calculate and print sales revenue (quantity * individualItemPrice)
        mov cx, [bx]
        mov ax, [di]
        mul cx
        call print_int
    
        ; Print a newline
        call print_newline

        ; Increment BP by 10 to point to the next word
        add bp, 10
        ; Increment SI, BX, DI by 2 to point to the next word
        add si, 2
        add bx, 2 
        add di, 2
        ; Repeat the loop for the next element
        jmp loop_start5
    
    ; End of the procedure
    done5:
        ret


;EXPLINATION
;This procedure is used to display a sales report for all the items in the inventory.
; For each item, it prints the item's id, name, sales quantity, and sales revenue (quantity * individualItemPrice). 
; It uses several helper procedures to print integers, strings, tabs, and newlines.





;=====================================================================================================================================================================================================





;  ────────────────────────
; ┊ 🚀  HELPER FUNCTIONS 🚀 ┊
;  ────────────────────────

terminate_program:
    ; Function to exit the program
    ; First it calls the draw_line function to draw a line on the screen
    call draw_line

    ; Load the effective address of the string "user_exit" into DX
    lea dx, user_exit
    ; Set the function number for "Output string to Console" in AH
    mov ah, 09h
    ; Interrupt 21h is DOS interrupt which invokes DOS services based on function number in AH
    int 21h 

    ; Call the draw_line function again to draw a line on the screen
    call draw_line

    ; Set the function number for "Terminate with return code" in AH
    mov ah, 4ch
    ; Invoke DOS services
    int 21h

refresh_display:
    ; Function to clear the screen
    ; Set the function number for "Scroll Window Up" in AH
    mov ah, 06h
    ; AL is the number of lines to scroll up (0 for clear all)
    mov al, 0
    ; BH is the attribute used for fill
    mov bh, 07h
    ; CX is the row/column of the upper left corner of the scroll window
    mov cx, 0
    ; DX is the row/column of the lower right corner of the scroll window
    mov dx, 184Fh
    ; Interrupt 10h is BIOS interrupt which provides access to video services
    int 10h
    ; Return from the function
    ret

draw_line:
    ; Function to draw a line
    ; Load the effective address of the string "Decor1" into DX
    lea dx, Decor1
    ; Set the function number for "Output string to Console" in AH
    mov ah, 09h
    ; Invoke DOS services
    int 21h
    ; Return from the function
    ret

print_tab:
    ; Function to print a tab character
    ; DL contains the ASCII value of the tab character
    mov dl, 09
    ; Set the function number for "Output character to Console" in AH
    mov ah, 02
    ; Invoke DOS services
    int 21h
    ; Return from the function
    ret

print_double_tab:
    ; Function to print two tab characters
    ; Print the first tab character
    mov dl, 09
    mov ah, 02
    int 21h

    ; Print the second tab character
    mov dl, 09
    mov ah, 02
    int 21h
    ; Return from the function
    ret

print_newline:
    ; Function to print a newline character
    ; DL contains the ASCII value of the newline character
    mov dl, 0ah
    ; Set the function number for "Output character to Console" in AH
    mov ah, 02
    ; Invoke DOS services
    int 21h
    ; Return from the function
    ret

print_asterisk:
    ; Function to print an asterisk
    ; Load the effective address of the string "Decor2" into DX
    lea dx, Decor2
    ; Set the function number for "Output string to Console" in AH
    mov ah, 09h 
    ; Invoke DOS services
    int 21h 
    ; Return from the function
    ret

;EXPLINATION
;These helper functions are often used in other parts of your program.
; They simplify tasks like printing special characters or strings, drawing lines, and clearing the screen.


;=====================================================================================================================================================================================================





main endp
end main

