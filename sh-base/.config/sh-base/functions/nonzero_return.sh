nonzero_return() {
    retval=$?
    [ "${retval:-0}" -ne 0 ] && printf "%s\n" "$retval"
}
