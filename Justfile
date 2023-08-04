set shell := ["fish", "-c"]

watch:
    while test -f .make; git ls-files | entr -pz make; notify sinterface $status; end
