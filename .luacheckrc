--std             = "ngx_lua+busted"
unused_args     = false
redefined       = false
max_line_length = false


globals = {
    --"_KONG",
    --"kong",
    --"ngx.IS_CLI",
}


not_globals = {
    "string.len",
    "table.getn",
}


ignore = {
    --"6.", -- ignore whitespace warnings
}

include_files = {
    "**/*.lua",
    "*.rockspec",
    ".busted",
    ".luacheckrc",
}

exclude_files = {
    "here/**",
    "samples/**",
}

