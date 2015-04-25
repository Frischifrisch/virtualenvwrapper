# -*- mode: shell-script -*-

test_dir=$(cd $(dirname $0) && pwd)
source "$test_dir/setup.sh"

oneTimeSetUp() {
    rm -rf "$WORKON_HOME"
    mkdir -p "$WORKON_HOME"
    unset VIRTUAL_ENV
    source "$test_dir/../virtualenvwrapper.sh"
    mkvirtualenv test1 >/dev/null 2>&1
    mkvirtualenv test2 >/dev/null 2>&1
    mkvirtualenv " env with space " >/dev/null 2>&1
    deactivate
}

oneTimeTearDown() {
    rm -rf "$WORKON_HOME"
}

setUp () {
    echo
}

tearDown () {
    deactivate >/dev/null 2>&1
}

test_allvirtualenv_all() {
    assertTrue "Did not find test1" "allvirtualenv pwd | grep -q 'test1$'"
    assertTrue "Did not find test2" "allvirtualenv pwd | grep -q 'test2$'"
    allvirtualenv pwd
    assertTrue "Did not find ' env with space '" "allvirtualenv pwd | grep -q ' env with space '"
}

test_allvirtualenv_spaces() {
    assertTrue "Command did not output The Zen of Python" "allvirtualenv python -c 'import this' | grep -q 'The Zen of Python'"
}

. "$test_dir/shunit2"
