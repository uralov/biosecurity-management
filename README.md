# biosecurity-management
We've got this `biosecurity` project. It contains a `biosecurity-management` component (product), which is a thing we have to build. We need some public developer tasks for probationary purposes (hiring/evaluating developers). That's the purpose of this repo.

## What's it about?

Biosecurity is about preventing bad things from happening (security) due to living things (bio). For examples, invasive species or plant diseases. Our client is particularaly interesting in preventing bad things happinging to Agriculture in a region.

Our `biosecurity-management` product is a web-based tool that biosecurity experts will use to manage information about biosecurity observations, including managing a subscription to notices about things they are interested in (but not other things).

There is a process where people make observations about potential biosecurity hazards. For example "here is a photo I took today, of what I think are some yellow crazy ants at some place where they don't belong". This happens outside the biosecurity-management product, but these observations are loaded into the biosecurity product. 

## What does "probationary purposes" mean?

Our real product is being developed in a private repo in a private GitHub organisation. Our core product team works there.

If you have been assigned a ticket in this repo, then you are a probationary team member. You will have been invited here by someone who is paying you to work on the ticket. This means we have hired you to work on the project for a short period, to evaluate your skills and teamwork. In other words, you are a probationary hire.

The tasks we assign you here are real, your code may be merged into the private product repo.

We plan to hire more people than we need for the core team, try them out, see what the rest of the team, mentors and managers think of them, and then bring people into the core team slowly, as we need them. So it's not exactly a pass/fail test, it's a chance to meet you and work with you on a single ticket/deliverable. If it works out, we may invite you to the core team immediately or a bit further down the track, as we need you in the team.


## How to work?

Our usual way of working is to have one "maintainer" per repo, who reviews and merges pull requests from contributors and basically takes personal responsibility for the code quality of the product. They are also a contributor to the product, and they may request code reviews from other people. There will be more than one person in the maintainer team, but that's just as a backup in case the real maintainer can't work for some reason.


### PR workflow

So, we use a "pull request workflow" in the real (private) product repos. We will also use the pull request workflow here. What you need to do is fork this repo, do your work, and make a PR back into this repo when you want review to start. If you are not familiar with the git forking workflow, see this: https://www.atlassian.com/git/tutorials/comparing-workflows/forking-workflow

You may make a task-specific branch in your fork, or not, we don't care. Your PR should be to the master branch in this repo.


### Commit comments

You should make small, frequent commits. We care about the quality of commit comments, that is one of the things we will be evaluating. This article is good advice about writing high quality git commit comments http://chris.beams.io/posts/git-commit/

There is this trick with GitHub where cross references to tickets (in git commits) result in links to tickets. It's neat, and we would like you to do that too. Because your code may be merged into another repo, when committing to this one, we'd like you to do it slightly lifferently, like this
```
blah blah blag showthething/biosecurity-management#1234, blah blah blah
```
That way, if your code is rebased into the upstream repo, the cross references to tickets here will still work. Under normal circumstances you would just do it like this
```
blah blah blag #1234, blah blah blah
```
