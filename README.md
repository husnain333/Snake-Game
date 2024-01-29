# Snake-Game
This is a simple Snake Game implemented in x86 Assembly language.

## Game Overview

The game is a console-based Snake Game where you control a snake to collect food and grow longer. The goal is to achieve the highest score without colliding with the snake's own body or the boundaries of the game screen.

## Features

- **Snake Movement:** Use arrow keys to control the snake's direction.
- **Scoring:** Score points by collecting food. The score is displayed on the screen.
- **Game Over:** The game ends if the snake collides with its own body or the game boundaries.
- **Menu and Welcome Screen:** The game includes a welcome screen and a menu with basic instructions.

## Getting Started

To play the game, assemble the provided code using an x86 Assembly compiler/assembler. Run the compiled executable to start the game.

```assembly
nasm -f bin snake_game.asm -o snake_game.com
snake_game.com
```

## Controls

- **Arrow Keys:** Move the snake in the corresponding direction.
- **1 Key:** Play the game.
- **Esc Key:** Exit the game.

## Acknowledgments

This Snake Game is a project by M HUSNAIN AFZAL for assembly language programming.

Feel free to contribute or provide feedback to enhance the game!
