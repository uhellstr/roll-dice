# roll-dice
Simple D&amp;D dice roller package for Emacs.

Clone this github repo to a path where you store none MELPA packages.

Put the following line in your emacs configuration file.

```
(add-to-list 'load-path "<your-path>/roll-dice")
(require 'roll-dice)
```
Example:

```
(add-to-list 'load-path "~/Documents/emacs-packages/roll-dice")
(require 'roll-dice)
```

Then restart emacs.

## Usage:

To call the dice roller use.

M-x roll-dice-run 
You will be prompted for the dice roll you want to performe.

Examples of rolls you can call

```
- d4          // Rolls a single 4 sided dice and return the sum.
- 2d6         // Rolls two six-sided dice and returns their sum.
- 3d4+1       // Rolls three four-sided dice, sums the results, and adds 1.
- 1d6+1d4+2   // Rolls 1d6 and 1d4, sums the result and then add 2 to the sum.
```
