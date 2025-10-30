;; extends

((template_string) @injection.content
 (#match? @injection.content "--sql\n*")
 ; (#match? @injection.content "--sql" "-- sql" "--SQL" "-- SQL")
 ; (#offset! @injection.content 0 1 0 -1)
 (#set! injection.include-children)
 (#set! injection.language sql))

