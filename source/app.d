import viva.json;
import viva.io;
import viva.types;
import viva.path;
import viva.file;
import viva.exceptions;
import viva.requests;
import viva.logging;
import viva.mistflake;
import viva.collections;
import viva.dvm;
import viva.math;
import viva.scrypt;
import viva.docker;

// TODO: Should I do enum values with uppercase or lowercase? Currently I have of both kinds
// TODO: Write unittests in each module instead of having this `app.d` file

void main()
{
	/*
	auto json = loads("");

	auto a = JSONValue(true);
	auto b = JSONValue(false);
	auto c = JSONValue("hello");
	println(a.type());
	println(a.boolean());
	println(b.type());
	println(b.boolean());
	println(c.type());
	println(c.str());

	JSONValue test1 = ["a": "b"];
	println(test1["a"].str());
	JSONValue test2 = ["a": 5];
	println(test2["a"].integer());
	*/

	printfln("Hello, World!", str(Color.BLUE, "a", Color.RESET));
	printfln("Hello, World!", str(Color.BACKGROUND_BOLD_BLUE, "b", Color.RESET));

	println(joinPath("/asaasa", "yeet/", "/hello/a.json"));
	println(getParent(joinPath("/asaasa", "yeet/", "/hello/a.json")));

	println(withAlternative("", "HELLO!!!"));
	println(sanitize("h,e,l,l,o", ","));
	println(envelop("[", "hello", "]"));

	println(str("Hello", ",", " ", "World", "!"));
	println("Hello, World!".hash);
	println(":)".repeat(3));

	checkNotEquals!(Exception, string, string)("a", "b", "OOF");
	checkEquals!(int, int)(1, 1, "YEET");
	check!Exception(true, "TEST1");
	check(!false, "TEST2");

	int x = 25;
	clampRef(x, 5, 20);
	println(x);
	checkEquals(x, 20, "x != 20");

	float y = 20.5;
	clampRef(y, 5.0, 20.0);
	println(y);
	checkEquals(y, 20.0, "y != 20.0");

	short z = 4;
	clampRef(z, 5, 20);
	println(z);
	checkEquals(z, 5, "x != 5");

	enum SomeStatus
	{
		CREATED,
		EXITED
	}
	string status = "Created";
	// TODO: this is an annoying way
	import std.typecons:Nullable;
	println(status.matches!(string, SomeStatus)("Created", SomeStatus.CREATED, Nullable!SomeStatus(SomeStatus.EXITED)));

	Response res = requests.get("http://httpbin.org/ip");
	println(res.data);

	Response res1 = requests.post("http://httpbin.org/post", ["accept": "application/json"]);
	println(res1.data);

	Logger logger = Logger("app", "", LogLevel.DEBUG);
	logger.info("HELLO");

	Logger logger2 = Logger("app", "", LogLevel.WARNING);
	logger2.info("HELLO2");

	MistflakeGenerator gen = MistflakeGenerator(0, 0);
	Mistflake id = gen.next();
	println(id.asString);
	MistflakeParser parser = MistflakeParser();
	Mistflake parsedId = parser.parse(id.asString);
	println(parsedId.time);
	println(parsedId.id);
	checkEquals(id.asString, parsedId.asString, "IDs doesn't match!");
	println(parsedId.toString());

	HashTable table = HashTable(5);
	println(table.set("hello", 5));
	println(table.get("hello"));
	println(table.set("hello2", 10));
	println(table.get("hello2"));
	println(table.set("hello3", 15));
	println(table.get("hello3"));
	println(table.set("hello4", 20));
	println(table.get("hello4"));
	println(table.set("hello5", 25));
	println(table.get("hello5"));
	println(table.set("hello6", 30));
	println(table.get("hello6"));
	println(table.set("hello7", 35));
	println(table.get("hello7"));
	println(table.entries);
	table.forEach((EntryValue value) { println(value); });

    string[] list = ["a", "b", "c"];
    list.forEach((string t) { println(t.toUpper); });
	string[] list2 = ["D:", "E;", "F!"];
	list2.forEach((string t) { println(t.toLower); });
	int[] ages = [16, 32];
	ages.forEach((ref int age) { age += 1; });
	println(ages);

	VM vm = VM([
		Instruction(Opcode.ICONST, 10),
		Instruction(Opcode.ICONST, 20),
		Instruction(Opcode.IADD),
		Instruction(Opcode.PRINT), // => 30
		Instruction(Opcode.ICONST, 5),
		Instruction(Opcode.ISUB),
		Instruction(Opcode.PRINT), // => 25
		Instruction(Opcode.INEG),
		Instruction(Opcode.PRINT), // => -25
		Instruction(Opcode.DUP),
		Instruction(Opcode.IMUL),
		Instruction(Opcode.PRINT), // => 625
		Instruction(Opcode.ICONST, 25),
		Instruction(Opcode.IDIV),
		Instruction(Opcode.PRINT), // => 25
		Instruction(Opcode.ICONST, -2),
		Instruction(Opcode.SWAP),
		Instruction(Opcode.ISUB),
		Instruction(Opcode.PRINT), // => -27
		Instruction(Opcode.HALT)
	]);
	vm.execute();

	Cache!int cache = Cache!int();
	cache.add("bob", 18);
	cache.add("daniel", 16);
	println(cache.get("daniel").get.integer);
	cache.update("bob", 19);
	println(cache.get("bob").get.integer);
	cache.remove("daniel");
	cache.forEach((EntryValue value) { println(value); });

	float[] pos = [34.6f, 94.7f, 23.0f];
	println(pos.join(", "));

	string password = "yeet123xyz";
	string hashedPassword = genScryptPasswordHash(password);
	bool doesMatch = checkScryptPasswordHash(hashedPassword, password);
	check(doesMatch, "password doesnt match? (something is wrong)");
	bool doesFalseMatch = checkScryptPasswordHash(hashedPassword, password ~ "a");
	check(!doesFalseMatch, "password does match? (something is wrong)");

	DockerOptions options = DockerOptions("hello-world");
	println(runDockerShell(options));
}
