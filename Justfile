set shell := ["fish", "-c"]

watch:
    while true; git ls-files | entr -cpz make; notify sinterface $status; end
