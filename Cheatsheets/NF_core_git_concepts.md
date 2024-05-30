# Git concepts for nf-core 

### git commit --amend 
Amending a recent commit by using the **amend** option to commit - be careful when
working with others on master/head as this will overwrite commit history. For example, we add some new content to the branch, commit it, but then realise we didn't include one specific part in our code. Instead of pushing this and then doing another add->commit, we can make make the changes in our code and perform a `git commit --amend -m "message"` or `git commit --amend --no-edit` to use the previous message.     

### git rebase
A nice [explanation](https://www.youtube.com/watch?v=0chZFIZLR_0) of rebase.
Rebase is used to combine branches with the main. Say we develop a branch,
and we're ready to combine it with the development that has taken place on
main. We would commit our branch, and then rebase our branch, all of the
history of the branch to the tip of the main stem, so if **A-B-C** is the main
stem, and our branch is **D-F-G**, after a rebase, our main would look like
**A-B-C-D-F-G**. `git config --global pull.rebase true` is a way to configure rebase so that we don't rely on merge much.   

### git merge 
Similar to rebase, this is a way to combine branches with the main stem. The
biggest different here is that with git merge, the branch history can be
retraced, but is represented in a single node, so using the prior example,
after unification we would have **A-B-C-D**, with D being the newly merged
contents.   

### git sqaush commit 
Just like merge and rebase, this also combines branches with the main, BUT
unlike merge, it will condense ALL of the history of the branch into a single
node, making it appear as if all the indels were make at once, thus losing the
history of the branch. This is mostly done to clean up and condense our code
base, knowing that the history feature is not essential. **A-B-C-D**. 

### git bisect 
Imagine we break something in the chain of development, we don't know where it
happened in the commits, but we know where it worked and were it was broken. We
bisect and split the commits by checking them out in the middle and testing the
software in incremental stages, communicating with bisect by sending commands
back `git bisect good` after which it will store this feedback and log the
commit hash, and then increment over to the next bisect.

### worktrees 
A handy feature which creates separate directories out of the git repo,
allowing one to maintain separate versions, or perhaps large modules part of
the software.   `git worktree add <path>`  

### github cli 
Github cli allows one to make 'shortcode' aliases for specific git operations, e.g. fork a project, clone it and enter it.   
```git
gitfork() {
  gh repo fork $1 --clone==true --remote=true 
} 

gitwork <repo> 
```








