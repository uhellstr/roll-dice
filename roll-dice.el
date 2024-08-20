;;; roll-dice.el --- A simple D&D dice roll -*- lexical-binding: t; -*-
;;
;; Copyright (C) 2022-2024  Free Software Foundation, Inc.
;;
;;
;; Author: Ulf Hellström <oraminute@gmail.com> Epico Tech
;; Maintainer: Ulf Hellström <oraminute@gmail.com>
;; Created: augusti, 05, 2024
;; Modified:
;; Version: 1.0
;; Keywords: languages lisp
;; Homepage: https://github.com/uhellstr
;; Package-Requires: ((emacs "28.1"))
;;
;; This file is NOT part of GNU Emacs.
;;
;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.;
;;
;;; Commentary:
;;
;; This function, roll-dice, simulates the rolling of dice based on input in the format commonly used in
;;  tabletop role-playing games like Dungeons & Dragons.
;;
;; The function accepts a string input representing various dice rolls, such as "2d6+3" or "1d20-2".
;;
;;  - It supports multiple dice types: d4, d6, d8, d10, d12, d20, and d100.
;;  - The input can specify multiple dice rolls and modifiers, e.g., "3d4+2d6+5".
;;  - The function uses regular expressions to parse the input and extract the number of dice, type of dice, and any modifiers.
;;  - It then calculates the total roll by summing the results of individual dice rolls and applying any modifiers.
;;  - The result is returned as the total value of the dice rolls including modifiers.
;;
;;  Example usage:
;;
;;  - (roll_dice "d4")          // Rolls a single 4 sided dice and return the sum.
;;  - (roll_dice "2d6")         // Rolls two six-sided dice and returns their sum.
;;  - (roll_dice "3d4+1")       // Rolls three four-sided dice, sums the results, and adds 1.
;;  - (roll_dice "1d6+1d4+2")   // Rolls 1d6 and 1d4, sums the result and then add 2 to the sum.
;;
;;  Description
;;
;;
;;; Code:
;;;

(provide 'roll-dice)

(define-derived-mode roll-dice fundamental-mode "roll-dice-run"
  "Major mode for roll playing roll-dice.")


;; Prompt for a doce role
(setq *my-dice-role* nil)
(defun roll-dice-get-dice()
  "Prompt user for dice(s) and eventual bonus."
  (setq *my-dice-role* (read-string "Dice(s) to role [+bonus] : ")))

;; Roll one or more dices and add eventual bonuses.
(defun roll-dices (input)
  "Simulate the roll of dice(s) based on the input string
   in tabletop RPG format, '2d6+3'."
  (let ((total 0)
        (dice-types '((4 . 4)
                      (6 . 6)
                      (8 . 8)
                      (10 . 10)
                      (12 . 12)
                      (20 . 20)
                      (100 . 100))))
    (dolist (part (split-string input "\\+"))
      (if (string-match "\\([0-9]*\\)d\\([0-9]+\\)" part)
          (let* ((num-str (match-string 1 part))
                 (type-str (match-string 2 part))
                 (num (if (string-empty-p num-str) 1 (string-to-number num-str)))
                 (type (string-to-number type-str)))
            (when (assoc type dice-types)
              (dotimes (_ num)
                (setq total (+ total (1+ (random (cdr (assoc type dice-types)))))))))
        (setq total (+ total (string-to-number part)))))
    total))

(defun roll-dice-run()
  "Simulate the roll of dice(s) based on tabletop RPG format, '2d6+3'."
   (interactive)
   (roll-dice-get-dice)
   (message "The result of the dice role [%s] is : %d"  *my-dice-role* (roll-dices *my-dice-role*)))

(add-hook 'roll-dice-mode-hook 'roll-dice-run)

;;; roll-dice.el ends here
