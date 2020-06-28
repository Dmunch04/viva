module viva.path.path;

import std.algorithm.searching : startsWith, endsWith;
import std.array : join, split;

/++
 + Joins multiple paths into one
 + Params:
 +      paths = All the paths to be joined
 + Returns: The new path
 +/
string joinPath(T...)(T paths)
{
    string resultPath = "";
    foreach (path; paths)
    {
        if (!path.endsWith("/")) path ~= "/";
        if (path.startsWith("/")) path = path[1..$];

        resultPath = resultPath ~ path;
    }

    if (!resultPath.startsWith("/")) resultPath = "/" ~ resultPath;

    return resultPath;
}

/++
 + Get the parent folder for a path
 + Params:
 +      path = The path to get the parent folder from
 + Returns: The path to the parent folder
 +/
string getParent(string path)
{
    if (path.endsWith("/")) path = path[0..$ - 1];
    string[] paths = path.split("/");
    if (!paths.length > 1) return "";
    return joinPath(join(paths[0..$ - 1], "/"), "/");
}