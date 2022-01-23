#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <fcntl.h>

#include "dispatcher.h"
#include "shell_builtins.h"
#include "parser.h"


static int dispatch_simple_command(struct command *pipeline);
static int dispatch_input_command(struct command *pipeline);
static int dispatch_output_command(struct command *pipeline);
static int dispatch_inout_command(struct command *pipeline);
static void set_flags(struct command *pipeline, int *p, int *i, int *o, int *num);
static int dispatch_piped_command(struct command *pipeline);

/**
 * dispatch_external_command() - run a pipeline of commands
 *
 * @pipeline:   A "struct command" pointer representing one or more
 *              commands chained together in a pipeline.  See the
 *              documentation in parser.h for the layout of this data
 *              structure.  It is also recommended that you use the
 *              "parseview" demo program included in this project to
 *              observe the layout of this structure for a variety of
 *              inputs.
 *
 * Note: this function should not return until all commands in the
 * pipeline have completed their execution.
 *
 * Return: The return status of the last command executed in the
 * pipeline.
 */
static int dispatch_external_command(struct command *pipeline)
{
	/*
	 * Note: this is where you'll start implementing the project.
	 *
	 * It's the only function with a "TODO".  However, if you try
	 * and squeeze your entire external command logic into a
	 * single routine with no helper functions, you'll quickly
	 * find your code becomes sloppy and unmaintainable.
	 *
	 * It's up to *you* to structure your software cleanly.  Write
	 * plenty of helper functions, and even start making yourself
	 * new files if you need.
	 *
	 * For D1: you only need to support running a single command
	 * (not a chain of commands in a pipeline), with no input or
	 * output files (output to stdout only).  In other words, you
	 * may live with the assumption that the "input_file" field in
	 * the pipeline struct you are given is NULL, and that
	 * "output_type" will always be COMMAND_OUTPUT_STDOUT.
	 *
	 * For D2: you'll extend this function to support input and
	 * output files, as well as pipeline functionality.
	 *
	 * Good luck!
	 */

	/*
	 * Some flags to determine how to carryout logic later, for things such as pipes/input files/outputfiles
	 */
	int pipes_present = 0;
	int inputf_present = 0;
	int outputf_present = 0;
	int num_cmds = 0;

	/*
	 * Setting the flags to appropriate values, _present is binary [0,1] and num_cmds is simply the number of commands in the pipeline (looping var)
	 */
	set_flags(pipeline, &pipes_present, &inputf_present, &outputf_present, &num_cmds);

	/* Two Base Cases, Pipes / No Pipes (No pipes should be a bit easier to implement) */
	if (pipes_present == 0) {
		/* If neither an input or an output file, simply execute the code provided for D1. */
		if (inputf_present == 0 && outputf_present == 0)
			return dispatch_simple_command(pipeline);

		/* Just an input file */
		else if (inputf_present == 1 && outputf_present == 0)
			return dispatch_input_command(pipeline);

		/* Just an output file */
		else if (inputf_present == 0 && outputf_present == 1)
			return dispatch_output_command(pipeline);

		/* The only remaining case, both input & output files*/
		else
			return dispatch_inout_command(pipeline);
	}
	/* The far more confusing case, where pipes are present. */
	else {
		/* Again, I'm going to start with a 'base' case, such as only a single pipe (|) (2 commands) */
		if (num_cmds == 2)
			dispatch_piped_command(pipeline);

		/* Otherwise, we will utilize some type of loop structure to do  >1 pipe */
		else {
			for (int i = 0; i < num_cmds; i++) {
				dispatch_piped_command(pipeline);
				pipeline = pipeline->pipe_to;
			}
		}
	}
	/*
	 * This return may be redundant
	 */
	return 0;
}
static int dispatch_piped_command(struct command *pipeline)
{
	int pipeFd[2];
	pid_t cpid1, cpid2;

	if (pipe(pipeFd) == -1) {
		fprintf(stderr, "Failure upon calling pipe()\n");
		return -1;
	}

	cpid1 = fork();
	if (cpid1 == -1) {
		fprintf(stderr, "Failure upon calling fork()\n");
		return -1;
	}
	if (cpid1 == 0) {
		close(pipeFd[0]);
		dup2(pipeFd[1], STDOUT_FILENO);
		if (execvp(pipeline->argv[0], pipeline->argv) == -1) {
			fprintf(stderr, "Command not found!\n");
			exit(-1);
		}
		close(pipeFd[1]);
	} else {
		close(pipeFd[1]);
		wait(NULL);
		cpid2 = fork();
		if (cpid2 == -1) {
			fprintf(stderr, "Failure upon calling fork()\n");
			return -1;
		}
		if (cpid2 == 0) {
			dup2(pipeFd[0], STDIN_FILENO);
			if (execvp(pipeline->pipe_to->argv[0], pipeline->pipe_to->argv) == -1) {
				fprintf(stderr, "Command not found!\n");
				exit(-1);
			}
		} else {
			close(pipeFd[0]);
			wait(NULL);
		}
	}
	return 0;
}
/*
 * dispatch_input_command(struct command *pipeline) - Command with IN files
 *
 * @pipeline:           The entire pipeline of parsed command
 *
 * Return: Some Number referencing the happiness displayed in our shell!
 */
static int dispatch_input_command(struct command *pipeline)
{
	int inFileFd = open(pipeline->input_filename, O_RDONLY);

	if (inFileFd == -1) {
		fprintf(stderr, "Failure upon calling open()\n");
		return -1;
	}
	/* Fork() a new process */
	int cpid1 = fork();

	if (cpid1 == -1) {
		fprintf(stderr, "Failure upon calling fork()\n");
		return -1;
	}
	/* Child Process */
	if (cpid1 == 0) {
		dup2(inFileFd, STDIN_FILENO);
		if (execvp(pipeline->argv[0], pipeline->argv) == -1) {
			fprintf(stderr, "Command not found!\n");
			exit(-1);
		}
	}
	/* Parent Process */
	else {
		close(inFileFd);
		wait(NULL);
	}
	return 0;
}
/*
 * dispatch_output_command(struct command *pipeline) - Command with OUT files
 *
 * @pipeline:           The entire pipeline of parsed command
 *
 * Return: Some Number referencing the happiness displayed in our shell!
 */
static int dispatch_output_command(struct command *pipeline)
{
	int outFileFd;
	/* If >> was used, to append */
	if (pipeline->output_type == COMMAND_OUTPUT_FILE_APPEND) {
		outFileFd = open(pipeline->output_filename, O_RDWR, O_APPEND, O_CREAT, 0710);
		if (outFileFd == -1) {
			fprintf(stderr, "Failure upon calling open()\n");
			return -1;
		}
	}
	/* If > was used, to truncate(overwrite) */
	else if (pipeline->output_type == COMMAND_OUTPUT_FILE_TRUNCATE) {
		outFileFd = open(pipeline->output_filename, O_RDWR, O_TRUNC, O_CREAT, 0710);
		if (outFileFd == -1) {
			fprintf(stderr, "Failure upon calling open()\n");
			return -1;
		}
	}
	/* Fork() a new process */
	int cpid1 = fork();

	if (cpid1 == -1) {
		fprintf(stderr, "Failure upon calling fork()\n");
		return -1;
	}
	/* Child Process */
	if (cpid1 == 0) {
		dup2(outFileFd, STDOUT_FILENO);
		if (execvp(pipeline->argv[0], pipeline->argv) == -1) {
			fprintf(stderr, "Command not found!\n");
			exit(-1);
		}
	}
	/* Parent Process */
	else {
		close(outFileFd);
		wait(NULL);
	}
	return 0;
}
/*
 * dispatch_inout_command(struct command *pipeline) - Command with both IN/OUT files
 *
 * @pipeline:           The entire pipeline of parsed command
 *
 * Return: Some Number referencing the happiness displayed in our shell!
 */
static int dispatch_inout_command(struct command *pipeline)
{
	/* Both an input & output file --Slightly busted*/
	int inFileFd = open(pipeline->input_filename, O_RDONLY);
	int outFileFd;

	if (inFileFd == -1) {
		fprintf(stderr, "Failure upon calling open()\n");
		return -1;
	}
	/* If >> was used, to append */
	if (pipeline->output_type == COMMAND_OUTPUT_FILE_APPEND) {
		outFileFd = open(pipeline->output_filename, O_WRONLY, O_APPEND, O_CREAT, 0710);
		if (outFileFd == -1) {
			fprintf(stderr, "Failure upon calling open()\n");
			return -1;
		}
	}
	/* If > was used, to truncate(overwrite) */
	else if (pipeline->output_type == COMMAND_OUTPUT_FILE_TRUNCATE) {
		outFileFd = open(pipeline->output_filename, O_WRONLY, O_TRUNC, O_CREAT, 0710);
		if (outFileFd == -1) {
			fprintf(stderr, "Failure upon calling open()\n");
			return -1;
		}
	}
	/* Fork() a new process */
	int cpid1 = fork();

	if (cpid1 == -1) {
		fprintf(stderr, "Failure upon calling fork()\n");
		return -1;
	}
	/* Child Process */
	if (cpid1 == 0) {
		dup2(inFileFd, STDIN_FILENO);
		dup2(outFileFd, STDOUT_FILENO);
		if (execvp(pipeline->argv[0], pipeline->argv) == -1) {
			fprintf(stderr, "Command not found!\n");
			exit(-1);
		}
	} else {
		close(inFileFd);
		close(outFileFd);
		wait(NULL);
	}
	return 0;
}
/*
 * dispatch_simple_command(struct command *pipeline) - The most basic command!
 *
 * @pipeline:           The entire pipeline of parsed command
 *
 * Return: Some Number referencing the happiness displayed in our shell!
 */
static int dispatch_simple_command(struct command *pipeline)
{
	/*
	 * To begin, I know we must at a minimum fork() to create the child
	 * process that will execute the new command. Return states: PID of
	 * child -> parent, 0 -> child, and -1 on failure.
	 */
	pid_t pid = fork();

	if (pid == -1) {
		fprintf(stderr, "Failure upon calling fork()\n");
		return -1;
	}
	/*
	 * Next, if the PID returned implies the parent process (non-zero), we
	 * can tell the parent process it must wait for its children... Reading
	 * the manual pages for wait() and waitpid(), its stated that
	 * wait(&status) is the same as waitpid(-1, &status, 0). Status = NULL
	 * results in no information being stores, and -1 waits for ANY(singular) child
	 * process, thus...
	 */
	else if (pid != 0) {
		wait(NULL);
		return 0;
	}
	/*
	 * Finally, the two parameters to execvp are the filename being looked
	 * for and the entire argv[] array. In all of the commands for D1, the
	 * name of the executable is the first part of the string, thus argv[0].
	 * Return states of execvp: only returns if an error, and the value is
	 * -1.
	 */
	else {
		if (execvp(pipeline->argv[0], pipeline->argv) == -1) {
			fprintf(stderr, "Command not found!\n");
			return -1;
		}
	}
	return 0;
}
/*
 * set_flags() - Sets the various flags related to what is contained in the parsed command. (< >/>> or | as well as # of commands)
 *
 * @pipeline:           The entire pipeline of parsed command
 *
 * Return: Nothing. Simply changes states.
 */
static void set_flags(struct command *pipeline, int *p, int *i, int *o, int *num)
{
/* in the case that there exists a pipeline */
	if (pipeline->output_type == COMMAND_OUTPUT_PIPE) {
		struct command *pipe_ptr = pipeline;

		if (pipe_ptr->input_filename != NULL)
			*i = 1;
		*num = *num + 1;
		*p = 1;
		while (pipe_ptr->output_type == COMMAND_OUTPUT_PIPE) {
			*num = *num + 1;
			pipe_ptr = pipe_ptr->pipe_to;
		}
		if (pipe_ptr->output_type != COMMAND_OUTPUT_STDOUT)
			*o = 1;
	}
	/* in the case its just 1 command */
	else {
		*num = 1;
		if (pipeline->input_filename != NULL)
			*i = 1;
		if (pipeline->output_filename != NULL)
			*o = 1;
	}
}
/**
 * dispatch_parsed_command() - run a command after it has been parsed
 *
 * @cmd:                The parsed command.
 * @last_rv:            The return code of the previously executed
 *                      command.
 * @shell_should_exit:  Output parameter which is set to true when the
 *                      shell is intended to exit.
 *
 * Return: the return status of the command.
 */
static int dispatch_parsed_command(struct command *cmd, int last_rv,
				   bool *shell_should_exit)
{
	/* First, try to see if it's a builtin. */
	for (size_t i = 0; builtin_commands[i].name; i++) {
		if (!strcmp(builtin_commands[i].name, cmd->argv[0])) {
			/* We found a match!  Run it. */
			return builtin_commands[i].handler(
				(const char *const *)cmd->argv, last_rv,
				shell_should_exit);
		}
	}

	/* Otherwise, it's an external command. */
	return dispatch_external_command(cmd);
}

int shell_command_dispatcher(const char *input, int last_rv,
			     bool *shell_should_exit)
{
	int rv;
	struct command *parse_result;
	enum parse_error parse_error = parse_input(input, &parse_result);

	if (parse_error) {
		fprintf(stderr, "Input parse error: %s\n",
			parse_error_str[parse_error]);
		return -1;
	}

	/* Empty line */
	if (!parse_result)
		return last_rv;

	rv = dispatch_parsed_command(parse_result, last_rv, shell_should_exit);
	free_parse_result(parse_result);
	return rv;
}
