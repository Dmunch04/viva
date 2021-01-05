module viva.docker.docker;

import viva.io;
import std.file;
import std.conv;
import std.array;
import std.getopt;
import std.process;
import std.algorithm;

/++
 + struct holding options for a docker operation
 +/
public struct DockerOptions
{
    /// the docker image to be run
    string image = null;
    /// custom command to be run
    string command = null;
    /// container user
    string user = null;
    /// container name
    string name = null;

    /// verbose mode
    bool verbose = false;
    /// detach the container
    bool detach = false;
    /// remove container
    bool remove = true;
    /// enable privileged mode (useful for GDB)
    bool privileged = false;
    /// enable GDB (GNU Debugger)
    bool gdb = false;
}

/++
 + struct holding info about a container
 +/
public struct DockerContainerInfo
{
    /// the id of the container
    string id;
    
    /// the name of the container
    string name;
    
    /// the image name of the container
    string image;
    
    /// the status of the container (`Exited` or `Created`)
    string status;
}

// TODO: maybe we shouldn't add the sudo? and have the user run the d project with sudo instead? so its not there if not needed?
version(Windows) private string[] defaultArgs = ["docker"];
else private string[] defaultArgs = ["sudo", "docker"];

private string runCommand(string[] args)
{
    string[] command = defaultArgs ~ args;
    auto res = execute(command);
    if (res.status != 0) throw new Exception("cannot run command: '" ~ command.join(" ") ~ "'. command exited with " ~ res.status.to!string);
    return res.output;
}

/++
 + run docker in a shell
 + Returns: ?
 +/
public string runDockerShell(DockerOptions options)
{
    string[] dockerArgs = ["run", "-it"];

    if (options.remove) dockerArgs ~= ["--rm"];
    if (options.detach) dockerArgs ~= ["--detach"];

    if (options.user != null) dockerArgs ~= ["--user", options.user];
    if (options.name != null) dockerArgs ~= ["--name", options.name];

    if (options.privileged) dockerArgs ~= ["--privileged"];

    if (options.gdb) dockerArgs ~= ["--cap-add=SYS_PTRACE", "--security-opt", "seccomp=unconfined"];

    dockerArgs ~= [options.image];
    
    if (options.command != null) dockerArgs ~= options.command.split(" ");

    return runCommand(dockerArgs);
}

/++
 + lists all containers
 + Returns: a list of objects of info of all the containers
 +/
public DockerContainerInfo[] runDockerContainerList()
{
    import std.uni : isWhite;

    string[] dockerArgs = ["ps", "-a", "--format", "\"table {{.ID}}\t{{.Names}}\t{{.Image}}\t{{.Status}}\""];

    string[] containers = runCommand(dockerArgs).split("\n");
    DockerContainerInfo[] containerInfos = [];

    foreach (container; containers)
    {
        string[] containerParts = container.split!isWhite;

        if (containerParts.length < 5) continue;

        containerInfos ~= DockerContainerInfo(containerParts[1], containerParts[2], containerParts[3], containerParts[4]);
    }

    return containerInfos;
}

/++
 + build a dockerfile
 + Returns: ?
 +/
public string runDockerBuild(string imageName, string dockerFile)
{
    string[] dockerArgs = ["build", "-f", dockerFile, "-t", imageName, "."];
    return runCommand(dockerArgs);
}