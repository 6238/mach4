# 2 Script Editor

---
**Navigation:** ← [Previous: 1 Introduction](introduction.md) | [Next: 3 Types of Scripts](types_of_scripts.md) → | [📋 Table of Contents](table_of_contents.md)
---

# Script Editor
Mach4 includes a built in script editor.  The editor can be found in the ‘Operator’ menu as ‘Edit/Debug Scripts’ (see Figure 2-1).  Selecting ‘Edit/Debut Scripts’ will open a window to select the script to be edited.  By default the ‘Macros’ folder for the current profile will be shown.  Select and open a file and it will be opened in the editor.
![Image 7225](images/image_7225.png)
*Figure 21: Operator Menu*
The script editor is essentially a fancy text editor, with some features specific to programming scripts and macros for Mach4.
![Image 7226](images/image_7226.png)
*Figure 22: Script Editor*
## File Menu
![Image 7227](images/image_7227.png)
*Figure 23: Script editor file menu.*
The file menu contains the controls “New”, “Open”, “Close”, “Save” and “Exit”.  Selecting new will open a blank file for creating a new script.  Open will open a window to allow the user to find and select an existing script to edit.  The close option will close the currently active file.  Save allows the user to save the script, there is also a “Save As” option that will can save the document as a new name or in a new location.  Exit simply closes the editor and any open files.
## Edit Menu
![Image 7228](images/image_7228.png)
*Figure 24: script editor edit menu.*
The edit menu contains the typical Cut, Copy, Paste, Select All, Undo/Redo controls as well as a couple specific to the script editor.  When Auto Complete Identifiers is checked the auto complete window will display when typing text in the editor.  If the text being typed partially matches known commands then the window will display the possible options.  When Auto Complete Identifiers is not checked the auto complete window will not be displayed automatically, but it can be manually shown with the Complete Identifier (Ctrl+K) command.  Comment/Uncomment will either add the “- -“ characters to selected text to change it to a comment, or remove the “- -“.
Settings displays window that allows the operator to change the color and style of different types of text in the program.
![Image 7229](images/image_7229.png)
*Figure 25: Script editor settings.*
## Search Menu
![Image 7230](images/image_7230.png)
*Figure 26: Script editor search menu*
In the search menu the user can find commands to search for and replace text, jump to specific line numbers and sort lines in alphanumerical order.  Numbers first, 0 to 9, then letters, A to Z.  
## Debug Menu
![Image 7231](images/image_7231.png)
*Figure 27: Script editor debug menu.*
The debug menu contains the controls for running and debugging programs.  Compile compiles the current program into a .mcc file.  Run will execute the script.
Start Debugging will start the debugger.  Debugging helps in diagnosing errors in the program.  There are a couple ways to run through the program in the debugging mode.  The Start Debugging command will change to Continue when in the debugging mode.  When the debugger starts the program will pause at the beginning and wait for input from the user.  Continue will run through the complete program.  The other controls, Step Into, Step Over, and Step Out allow the user to step through the script line by line.  Step Into and Step Over differ in the way functions are executed.  Step Into will make a single step into the function.  Step Over will execute the entire function and pause at the end.  If a function is stepped into, the Step Out command will execute the remaining portion of the function and pause at the end.
The Console shows error messages and debugging data while running programs.
***Help Menu***
The Help Menu displays the About information.
## Toolbar
![Image 7232](images/image_7232.png)
*Figure 28: Script editor toolbar*
The toolbar in the script editor contains some of the most common controls.  From left to right:
•       Create new document
•       Open existing document
•       Save current document
•       Save all open documents
•       Cut
•       Copy
•       Paste  Undo
•       Redo
•       Search for text
•       Find and replace text

---
**Navigation:** ← [Previous: 1 Introduction](introduction.md) | [Next: 3 Types of Scripts](types_of_scripts.md) → | [📋 Table of Contents](table_of_contents.md)
---