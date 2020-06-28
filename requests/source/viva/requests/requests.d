module viva.requests.requests;

// TODO: Replace with viva JSON lib once ready
import std.json;

private Requests _requests = Requests();
/// Perform simple web requests
@property public Requests requests() { return _requests; }

/++
 + An object for holding information about request reponses
 +/
struct Response
{
    /++
     + The response code
     +/
    uint code;

    /++
     + The response JSON data
     +/
    JSONValue data;
}

// TODO: How do we find response code?
private struct Requests
{
    /++
     + Perform a `GET` request on the specified URL
     + Params:
     +      url = The URL to perform the request to
     + Returns: The reponse data from the request
     +/
    public Response get(string url)
    {
        import std.net.curl : get;

        return Response(0, parseJSON(get(url)));
    }

    /++
     + Perform a `POST` request on the specified URL
     + Params:
     +      url = The URL to perform the request to
     +      data = The data to be sent with the request
     + Returns: The reponse data from the request
     +/
    public Response post(string url, string[string] data)
    {
        import std.net.curl : post;

        return Response(0, parseJSON(post(url, data)));
    }

    /++
     + Perform a `PUT` request on the specified URL
     + Params:
     +      url = The URL to perform the request to
     +      data = The data to be sent with the request
     + Returns: The reponse data from the request
     +/
    public Response put(string url, const(char[]) data)
    {
        import std.net.curl : put;

        return Response(0, parseJSON(put(url, data)));
    }

    /++
     + Perform a `DELETE` request on the specified URL
     + Params:
     +      url = The URL to perform the request to
     + Returns: The reponse data from the request
     +/
    public Response del(string url)
    {
        import std.net.curl : del;

        del(url);
        // TODO: Hmm?
        return Response(0, parseJSON("{}"));
    }
}