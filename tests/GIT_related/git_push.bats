setup() {
    DIR="$( cd "$( dirname "$BATS_TEST_FILENAME" )" >/dev/null 2>&1 && pwd )"
    PATH="$DIR/../../GIT_related:$PATH"
}

@test "can run script" {
    echo $DIR
    git_push.sh
}