#include <errno.h>
#include <dirent.h>
#include <limits.h>
#include <stdio.h>
#include <string.h>
#include <sys/types.h>
#include <unistd.h>
int flag;

static void printIndent(int indent);
static int printTree(char *path, int indent);

int main(int argc, char *argv[])
{
	/*
	 * check if there is an argument given, if so use this as the root
	 * of the tree.
	 */
	if (argc > 1) {
		char *root;

		root = argv[1];		
		printTree(root, 0);
	}
	/*
	 * Otherwise, use the current directory as the root for the tree.
	 */
	else {
		char root[PATH_MAX];

		if (getcwd(root, sizeof(root)) != NULL) {
			printTree(root, 0);
		} else {
			fprintf(stderr, "ROOT == NULL\n");
			flag++;	
		}		
	}
	return flag;
}

void printIndent(int indent)
{
	if (indent != 0) {
		for (int i = 0; i < indent; i++)
			printf("\t");
	}
}

int printTree(char *path, int indent)
{
	struct dirent *dptr;
	DIR *dir = opendir(path);
	
	if (!dir) {
		fprintf(stderr, "Directory not accessible\n");
		flag++;
		return flag;
	}
	while ((dptr = readdir(dir)) != NULL) {
		if (strcmp(dptr->d_name, ".") != 0 && strcmp(dptr->d_name, "..") != 0) {
			if (dptr->d_type == DT_LNK) {
				char link_loc[PATH_MAX];
				char next_target[PATH_MAX];
				size_t len = PATH_MAX;

				snprintf(link_loc, sizeof(link_loc), "%s/%s", path, dptr->d_name);
				len = readlink(link_loc, next_target, PATH_MAX-1);
				next_target[len] = '\0';
				printIndent(indent);
				printf("SYM %s -> %s\n", dptr->d_name, next_target);
				continue;
			} else if (dptr->d_type == DT_DIR) {
				char node[512];

				printIndent(indent);
				printf("%s\n", dptr->d_name);
				snprintf(node, sizeof(node), "%s/%s", path, dptr->d_name);				
				printTree(node, indent+1);
				continue;
			} else {
				printIndent(indent);
				printf("%s\n", dptr->d_name);
				continue;
			}
		}
	}
	closedir(dir);
	return flag;
}
