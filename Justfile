set shell := ["fish", "-c"]

watch:
    while true; git ls-files | entr -pz make; notify sinterface $status; end
