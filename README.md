# Description
Bash script to create web project directory tree.

**Did it for my server setup, thought to share.**

**I'm not an expert on bash scripting, but everything works just fine and doing its job.**

## Highlights

1. Script created for this particular setup in mind: NGiNX, behind it Apache on reverse proxy, both run under user 'www' (but easy to use on any setup you have with minor changes).
2. All projects are created in ~/www/projects directory.
3. Initial set of created folders are as folows (lets say project is called "vanadium"):

	* `~/www/projects/vanadium`	*Home directory for project, later on in text as "$HOME".*
	* `$HOME/void/`				*For fallback/gag/plug etc.*
	* `$HOME/void/logs/`		*For web server log files.*
	* `$HOME/void/root/`		*Script root.*
	* `$HOME/void/root/public/`	*For index and assets (everything that needs access from outside).*
	* `$HOME/prod/`				*Production environment.*
	* `$HOME/prod/logs/`
	* `$HOME/prod/root/`
	* `$HOME/prod/root/public/`
	* `$HOME/dev/`				*Development environment.*
	* `$HOME/dev/logs/`
	* `$HOME/dev/root/`
	* `$HOME/dev/root/public/`
	* `$HOME/test/`				*Test environment.*
	* `$HOME/test/logs/`
	* `$HOME/test/root/`
	* `$HOME/test/root/public/`
	* `$HOME/sbox/`				*Sandbox environment (for crazy experiments).*
	* `$HOME/sbox/logs/`
	* `$HOME/sbox/root/`
	* `$HOME/sbox/root/public/`
	* `$HOME/old/`				*Old version (optional).*
	* `$HOME/old/logs/`
	* `$HOME/old/root/`
	* `$HOME/old/root/`
	* `$HOME/old/root/public/`

4. NGiNX and Apache log files are created for each environment and all needed file ownerships and permissions are set.
5. Uses promts for user input and validates it.
6. Got informative messages.
7. Diversive logic.
8. Catches CTRL+C and informs about it.
9. Uses bold text in places of interest and uses text tweeks for better readability of messages.
10. Neat :smirk:
