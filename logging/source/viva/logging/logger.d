module viva.logging.logger;

import viva.io;

/++
 + Enum representing the level of logging
 +/
enum LogLevel : uint
{
    DEBUG = 10,
    INFO = 20,
    WARNING = 30,
    ERROR = 40,
    CRITICAL = 50
}

/++
 + The `Logger` struct manages logging with support for different levels and different outputs
 +/
struct Logger
{
    private {
        string name;
        // TODO: Replace with an output stream or something like that?
        string output = "";
        LogLevel level = LogLevel.WARNING;
    }

    /++
     + Default constructor
     + Params:
     +      name = The name of the application
     +      output = Output file. Leave empty if console is used (Default = `""`)
     +      level = The log level of the logger. The logger won't log anything lower than this level (Default = `LogLevel.WARNING`)
     +/
    this(string name, string output = "", LogLevel level = LogLevel.WARNING)
    {
        this.name = name;
        this.output = output;
        this.level = level;
    }

    private void log(LogLevel msgLevel, string msg)
    {
        if (msgLevel >= level)
        {
            switch (output)
            {
                case "": println(msg); break;
                default: println(msg); break;
            }
        }
    }

    /++
     + Returns the log level of the logger
     +/
    @property public LogLevel logLevel()
    {
        return level;
    }

    /++
     + Logs a debug log (`LogLevel.DEBUG`)
     + Params:
     +      msg = The message of the log
     +/
    public void _debug(string msg)
    {
        log(LogLevel.DEBUG, msg);
    }

    /++
     + Logs an info log (`LogLevel.INFO`)
     + Params:
     +      msg = The message of the log
     +/
    public void info(string msg)
    {
        log(LogLevel.INFO, msg);
    }

    /++
     + Logs a warning log (`LogLevel.WARNING`)
     + Params:
     +      msg = The message of the log
     +/
    public void warning(string msg)
    {
        log(LogLevel.WARNING, msg);
    }

    /++
     + Logs an error log (`LogLevel.ERROR`)
     + Params:
     +      msg = The message of the log
     +/
    public void error(string msg)
    {
        log(LogLevel.ERROR, msg);
    }

    /++
     + Logs a critical log (`LogLevel.CRITICAL`)
     + Params:
     +      msg = The message of the log
     +/
    public void critical(string msg)
    {
        log(LogLevel.CRITICAL, msg);
    }
}