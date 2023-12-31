# Setup git
read -rp "What is your git username? " username
read -rp "What is your git email? " email

# Set git username and email
git config --global user.name "$username" >/dev/null
git config --global user.email "$email" >/dev/null

# Set git editor
git config --global core.editor "nvim" >/dev/null

# Set git diff tool enhancements
git config --global core.pager "diff-so-fancy | less --tabs=4 -RFX" >/dev/null
git config --global interactive.diffFilter "diff-so-fancy --patch" >/dev/null

# Setup color in git user interface
git config --global color.ui true >/dev/null

# Setup change highlighting in git diff
git config --global color.diff-highlight.oldNormal "red bold" >/dev/null
git config --global color.diff-highlight.oldHighlight "red bold 52" >/dev/null
git config --global color.diff-highlight.newNormal "green bold" >/dev/null
git config --global color.diff-highlight.newHighlight "green bold 22" >/dev/null

# Setup color in git diff
git config --global color.diff.meta "11" >/dev/null
git config --global color.diff.frag "magenta bold" >/dev/null
git config --global color.diff.func "146 bold" >/dev/null
git config --global color.diff.commit "yellow bold" >/dev/null
git config --global color.diff.old "red bold" >/dev/null
git config --global color.diff.new "green bold" >/dev/null
git config --global color.diff.whitespace "red reverse" >/dev/null

echo "Configured git for workflow publishing"
