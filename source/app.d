import std.stdio;
	
void printOptions(inout string[string] options)
{
	foreach (k, option; options)
	{
		version (FishShell)
		{
			writeln("set -g -x " ~ k ~ " " ~ option ~ ";");
		}
		version (BashShell)
		{
			writeln("export " ~ k ~ "=" ~ option);
		}
	}
}

void printVersion()
{
	writeln("Docker Host v1.0 by Jonathan Gerlach\n");
}

void printHelp()
{
	writeln("Commands:");
	writeln("\tenv <environment name>\tShow the environment variables for an environment.");
	writeln("\tlist\t\t\tList the environments.");
	writeln("\thelp\t\t\tPrint this message.");
	writeln("\nExamples:\n");
	writeln("- List environments");
	writeln("# dockerHost list");
	writeln("JoyentEast\nHomeWindows\n");
	writeln("- Load an environment's variables");
	version (FishShell)
	{
		writeln("# eval (dockerHost env JoyentEast)\n");
	}
	version (BashShell)
	{
		writeln("# eval $(dockerHost env JoyentEast)\n");
	}
}

int main(string[] args)
{
	immutable auto configurations =
	[
		"JoyentEast":
		[
			"DOCKER_CERT_PATH": "~/.sdc/docker/JonathanGerlach",
			"DOCKER_HOST": "tcp://us-east-1.docker.joyent.com:2376",
			"DOCKER_CLIENT_TIMEOUT": "300",
			"DOCKER_TLS_VERIFY": "300",
			"COMPOSE_HTTP_TIMEOUT": "1"
		],
		"HomeWindows":
		[
			"DOCKER_CERT_PATH": "~/.docker/win2016docker.home.thegerlach.net-DockerKeys/",
			"DOCKER_HOST": "tcp://win2016docker.home.thegerlach.net:2376",
			"DOCKER_TLS_VERIFY": "1"
		]
	];
	
	if (!(args is null) &&
		args.length > 1)
	{
		auto first = args[1];
		if (first == "list")
		{
			foreach (configurationName, configuration; configurations)
			{
				writeln(configurationName);
			}
		}
		else if (first == "env" &&
			args.length > 2)
		{
			auto second = args[2];
			auto options = configurations[second];
			if (options)
			{
				printOptions(configurations[second]);
			}
		}
		else if (first == "help" ||
			first == "--help")
		{
			printHelp();
		}
		else if (first == "version" ||
			first == "--version")
		{
			printVersion();
		}
		else
		{
			printHelp();
		}
	}
	else
	{
		printVersion();
		printHelp();
	}
	
	return 0;
}