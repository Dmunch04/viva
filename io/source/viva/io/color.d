module viva.io.color;

/++
 + Enum holding the ANSI color reprentation
 +/
enum Color : string
{
    RESET = "\u001b[0m",
    CLEAR = "\u001b[0m",

    BOLD = "\u001b[1m",
    UNDERLINE = "\u001b[4m",
    REVERSED = "\u001b[7m",

    BLACK = "\u001b[30m",
    BOLD_BLACK = "\u001b[30;1m",
    RED = "\u001b[31m",
    BOLD_RED = "\u001b[31;1m",
    GREEN = "\u001b[32m",
    BOLD_GREEN = "\u001b[32;1m",
    YELLOW = "\u001b[33m",
    BOLD_YELLOW = "\u001b[33;1m",
    BLUE = "\u001b[34m",
    BOLD_BLUE = "\u001b[34;1m",
    PURPLE = "\u001b[35m",
    BOLD_PURPLE = "\u001b[35;1m",
    CYAN = "\u001b[36m",
    BOLD_CYAN = "\u001b[36;1m",
    WHITE = "\u001b[37m",
    BOLD_WHITE = "\u001b[37;1m",

    BACKGROUND_BLACK = "\u001b[40m",
    BACKGROUND_BOLD_BLACK = "\u001b[40;1m",
    BACKGROUND_RED = "\u001b[41m",
    BACKGROUND_BOLD_RED = "\u001b[41;1m",
    BACKGROUND_GREEN = "\u001b[42m",
    BACKGROUND_BOLD_GREEN = "\u001b[42;1m",
    BACKGROUND_YELLOW = "\u001b[43m",
    BACKGROUND_BOLD_YELLOW = "\u001b[43;1m",
    BACKGROUND_BLUE = "\u001b[44m",
    BACKGROUND_BOLD_BLUE = "\u001b[44;1m",
    BACKGROUND_PURPLE = "\u001b[45m",
    BACKGROUND_BOLD_PURPLE = "\u001b[45;1m",
    BACKGROUND_CYAN = "\u001b[46m",
    BACKGROUND_BOLD_CYAN = "\u001b[46;1m",
    BACKGROUND_WHITE = "\u001b[47m",
    BACKGROUND_BOLD_WHITE = "\u001b[47;1m"
}