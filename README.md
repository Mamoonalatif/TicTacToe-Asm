# 🕹️ Tic Tac Toe – Assembly Language Game

A fully functional **Tic Tac Toe** (also known as **Noughts and Crosses**) console game written in **x86 Assembly (8086)** using **BIOS interrupts** and **MS-DOS INT 21h services**.

## 📜 Description

This is a two-player turn-based **Tic Tac Toe game** implemented in Assembly Language using TASM/MASM. The game uses BIOS and DOS interrupts for screen output and user input, and displays an interactive board with rules and instructions.

## 🎮 Features

* ASCII-art animated splash screen
* Rules screen before the game begins
* Clean and readable 3x3 game board
* Player 1 uses **'X'**, Player 2 uses **'O'**
* Input-based mark placement (1–9)
* Turn-based logic with player switching
* Cell validation to prevent overwriting
* Win detection for all 8 combinations
* Draw detection when all cells are filled
* Option to **play again** after game ends

![image](https://github.com/user-attachments/assets/9779963f-2e5b-4d85-a87d-1a9a6985deb1)
![image](https://github.com/user-attachments/assets/a08c895f-efcd-4927-8d7e-071c09b94a8f)


## 🛠 Technologies Used

* Assembly Language (x86 – 8086)
* BIOS Interrupts (`INT 10h`)
* DOS Interrupts (`INT 21h`)
* Debug/EMU8086/DOSBox for running/testing

## 🧠 Game Logic

* The game board is represented using variables `c1` to `c9` corresponding to each cell.
* Turns are toggled by the `player` variable (49 = '1', 50 = '2').
* `cur` holds the ASCII for the current player's mark ('X' or 'O').
* After each move, the game checks all **8 winning combinations**:

  * Rows: \[1,2,3], \[4,5,6], \[7,8,9]
  * Columns: \[1,4,7], \[2,5,8], \[3,6,9]
  * Diagonals: \[1,5,9], \[3,5,7]
* If none of the win conditions are met and the board is full (`moves == 9`), the game declares a draw.

## 🕹️ Controls

* Enter a **number from 1 to 9** to mark that cell with your symbol.
* You will be prompted again if the cell is already taken.
* After a win or draw, press any key to continue.
* The game then asks whether you'd like to **play again** (`Y/N`).

## 📦 How to Run

1. Copy the `.asm` file into your development folder.
2. Use **TASM/MASM** or **EMU8086** to compile the program.
3. Run it using **EMU8086**, **DOSBox**, or any compatible 16-bit emulator.
4. Follow the prompts in the console to play.


## 🧾 File Structure

* `tictactoe.asm`: Main game file containing:

  * Splash screen
  * Rule screen
  * Game logic
  * Input handling
  * Win/draw checking
  * Game loop and UI rendering

## ✍️ Developer

Developed by **Mamoona**.


