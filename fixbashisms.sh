#!/bin/bash

# http://mywiki.wooledge.org/Bashism
# see checkbashisms

fatal()
{
	echo "FATAL: $@"
	exit 1
}

remove_bashisms()
{
	local FILENAME="$1"
	test -w "$FILENAME" || fatal "File '$FILENAME' is missed or read only"

	cp $FILENAME ${FILENAME}~

	subst "s|^pushd \(.*\)|cd \1 >/dev/null|g" $FILENAME
	subst "s|^popd|cd - >/dev/null|g" $FILENAME

	# {1,2} translation
	# FIXME: miss first spaces
	while read -r n ; do
		echo "$n" | grep -v "{.*}" && continue
		rs="$(echo "$n" | perl -pe "s|.*\s(.*?{.*?}.*?)\s.*|\1|g" )"
		# eval with bash (TODO: parse without bash)
		rsq=$(echo "$rs" | tr "$" "@" | sed -e "s|@|\\$|g")
		echo $rs - $rsq
		res=$(eval echo "$rsq")
		echo "$n" | perl -pe "s|$rs|$res|g"
	done < $FILENAME >$FILENAME.tmp

	[ -s "$FILENAME.tmp" ] && mv -f $FILENAME.tmp $FILENAME

}

for i in "$@" ; do
	remove_bashisms $i
	#TODO: verbose
	#checkbashisms $SPECNAME
done
