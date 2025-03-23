# Calculator-Interpreter-1

## This program implements a simple calculator using Lex and Yacc.

## 1️⃣ How to Compile and Run

To compile and run the calculator interpreter, follow these steps:

1. Ensure that `flex`, `bison`, and `gcc` are installed on your system.
2. Clone the repository or download the code files, then navigate to the directory containing them.
3. Open a terminal and execute the following commands:
   ```sh
   lex calculator.l
   yacc -d calculator.y
   gcc lex.yy.c y.tab.c -o calculator -lm  # (Include -lm for the math library)
   ./calculator
   ```
4. Upon execution, you should see the following message:
   ```
   Calculator Interpreter. Enter any Arithmetic Expression:
   ```
5. Enter an arithmetic expression and press enter to receive the result.

> **Note:** To evaluate a new expression, restart the program by running `./calculator` again.

---

## 2️⃣ Design Decisions

### Lexical Analysis (`calculator.l`)

- Tokenizes numbers, operators (`+`, `-`, `*`, `/`, `**`), and parentheses.
- Ignores whitespace characters.
- Any character that does not match the defined tokens is considered invalid. Lex file reports and counts invalid characters but continues execution instead of terminating immediately.This allows the program to detect and report all invalid characters in the input.
- Supports floating-point numbers using the regex `[0-9]+(\.[0-9]+)?`.

### Syntax Analysis (`calculator.y`)

- Defines grammar rules for arithmetic expressions, supporting:
  - Addition (`+`), Subtraction (`-`)
  - Multiplication (`*`), Division (`/`)
  - Exponentiation (`**`), Parentheses
- Implements error handling for invalid characters and division by zero.
- Operator precedence and associativity:
  1. Exponentiation (`**`)
  2. Parentheses
  3. Multiplication (`*`) & Division (`/`)
  4. Addition (`+`) & Subtraction (`-`)

### Data Types

- Supports floating-point arithmetic using `float` in both Lex and Bison.
- Utilizes `YYSTYPE` union for passing values between Lex and Bison.

### Error Handling

-The Lex file detects invalid characters and increments a counter(invalid_char_count). The Yacc file checks this counter and reports an error if invalid characters are present.

-The Yacc file checks for division by zero and reports an error if encountered.

---

## 3️⃣ Implementation Steps

### Lexical Analysis:

- Defined tokenization rules in `calculator.l` for numbers, operators, and parentheses.
- Implemented a mechanism to detect, print, and count invalid characters.
- Used `atof` to convert numeric strings into floating-point values.
- Included support for exponentiation (`**`).

### Syntax Analysis:

- Defined grammar rules in `calculator.y` to parse arithmetic expressions.
- Implemented operator precedence and associativity for correct evaluation.
- Added error handling for invalid characters and division by zero.
- Used the `pow` function from the math library for exponentiation.

### Integration:

- Integrated Lex and Yacc by defining `YYSTYPE` as a union in the Yacc file and referencing it in the Lex file.
- Shared the `invalid_char_count` variable between Lex and Yacc to track invalid characters.

### Testing:

- Verified correct parsing and evaluation with valid arithmetic expressions (e.g., `2 + 3 * (4 - 1)`).
- Ensured proper error handling for invalid characters (e.g., `2 + &`).
- Tested edge cases, including division by zero and floating-point precision issues.

### Example Inputs and Outputs

-Input: 3.5 + 2.1 \* (4 - 1)
-Output: Result=9.80

-Input: 2\*\*2 - 7
-Output: Result= -3.0

-Input: 4g8hk
-Output: Invalid character: g
         Invalid character: h
         Invalid character: k
         Error: Invalid characters in input

-Input: 5/0
-Output: Error: Divide by zero error
