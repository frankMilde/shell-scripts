envfile="${HOME}/.gnupg/gpg-agent.env"

if test -f "$envfile" && kill -0 $(grep GPG_AGENT_INFO "$envfile" | cut -d: -f 2) 2>/dev/null; then
	eval "$(cat "$envfile")"
else
	#eval "$(gpg-agent --enable-ssh-support --daemon --debug-level 9 --keep-tty --pinentry-program=/usr/bin/pinentry-curses --write-env-file "$envfile")"
	eval "$(gpg-agent --enable-ssh-support --daemon --write-env-file "$envfile")"
fi
