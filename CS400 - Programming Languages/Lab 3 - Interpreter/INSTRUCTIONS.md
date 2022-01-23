# Benjamin Jessing - Individual Lab #3 Repository

## Viewing your class repo(s) on GitHub

At the following page, you should see a repo for each assignment, and
an individual/team repo for each assignment, where you can submit
your work. All of these repos are private, so you'll need
to log in to Github first.

[https://github.com/mines-csci400](https://github.com/mines-csci400)

## Setup: cloning this repository

To get started, first make a local copy of this repository, and
enter the created directory:
```
git clone https://github.com/mines-csci400/f20a-user-bjessing-lab3.git
cd f20a-user-bjessing-lab3
```

## Git remotes

Git "remotes" allow you to push/pull to/from other repositories.
To look at your current remotes:
```
git remote -v
```
The default remote is called `origin`, and it should point to your
repository:
```
https://github.com/mines-csci400/f20a-user-bjessing-lab3.git
```

## Working on an assignment

To bring in the instructor's skeleton code for this assignment,
you should create a remote that points to the
corresponding assignment repository:
```
git remote add upstream https://github.com/mines-csci400/f20a-assignment-lab3.git
git pull upstream master --allow-unrelated-histories
```
You can then edit the files as
needed to complete the assignment, make as many commits as needed, and
finally do the following to push to your user repo:
```
git push origin master
```
If for some reason you need to bring in the instructor's version of the
assignment again (e.g., due to bug fixes, hints, clarifications, etc.):
```
git pull upstream master
```
(no need for `--allow-unrelated-histories` the second time).
