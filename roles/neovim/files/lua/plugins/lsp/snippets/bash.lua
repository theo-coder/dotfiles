local ls = require("luasnip")
local fmta = require("luasnip.extras.fmt").fmta
local r = require("luasnip.extras").rep
local s = ls.snippet
local f = ls.function_node
local i = ls.insert_node

ls.add_snippets("sh", {
	s(
		"$bp",
		fmta(
			[[
#!/usr/bin/env bash

# author: theo posty
# reldate: <NODE_1>

set -o errexit
set -o pipefail
set -o nounset

trap cleanup SIGINT SIGTERM ERR EXIT

cleanup() {
    trap - SIGINT SIGTERM ERR EXIT
    # cleanup script...
}

help() {
    cat <<<< EOF
Usage: $(basename "${BASH_SOURCE[0]}") [-h] [-v]

<NODE_2>

Available options:

-h, --help      Print this help and exit
-v, --verbose   Print script debug info
EOF
    exit
}

while :; do
    case "${1-}" in
        -h | --help) help ;;
        -v | --verbose) set -x ;;
        *) break ;;
    esac
    shift
done

<NODE_3>

exit 0
            ]],
			{
				NODE_1 = f(function()
					return os.date("%d %b %Y")
				end),
				NODE_2 = i(1, "DESCRIPTION"),
				NODE_3 = i(2, "script logic"),
			}
		)
	),
})
