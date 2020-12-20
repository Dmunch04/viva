module viva.file.file;

import std.stdio;
import std.path;

///
enum FileAccessFlag
{
    READ = 1,
    WRITE = 2,
}

///
enum FileCreationFlag
{
    CREATE = 1,
    TRUNCATE = 2,
}

/++
 + The `File` struct is a representation of a file on the PC 
 +/
struct File
{
    /++
     + The contents of the file
     +/
    string content;

    /++
     + The size of the file
     +/
    size_t size;

    /++
     + Close the file connection
     + Returns: A bool indicating the success
     +/
    bool close()
    {
        return true;
    }
}

/++
 + The general exception for file operations
 +/
class FileException : Exception
{
    /++
     + Takes in the exception message
     + Params:
     +      message = The exception message
     +/
    this(string message)
    {
        super(message);
    }
}

/++
 + Opens a file
 + Params:
 +      path = The path to the file
 +      mode = The file open mode
 + Returns: The new `File` object
 +/
public File open(string path, FileCreationFlag creationFlag = FileCreationFlag.TRUNCATE)
{
    return File("", 0);
}

/++
 + Checks whether or not the file/folder at the destination exists
 + Params:
 +      path = The path to the file/folder
 + Returns: A bool indicating whether or not the file/folder exists
 +/
public bool exists(string path)
{
    return false;
}

/++
 + Creates a file at the destination
 + Params:
 +      path = The path to the folder in which the file should be creating in
 +      fileName = The files name
 +      throwError = If an exception should be thrown at the event of an error
 +/
public bool createFile(string path, string fileName = "", bool throwError = false)
{
    try
    {
        auto file = open(buildPath(path, fileName)/*, "w"*/);
        file.close();
        
        return true;
    }
    catch (FileException e)
    {
        if (throwError)
            writeln(e);

        return false;
    }
}