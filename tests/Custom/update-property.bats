#!/usr/bin/env bats

setup() {
    SCRIPT="$BATS_TEST_DIRNAME/../../Custom/update-property.sh"
    export TEST_DIR
    TEST_DIR="$(mktemp -d)"
    export CASES_DIR="$TEST_DIR/cases"
    mkdir -p "$CASES_DIR"

    export ORIG_DIR="$PWD"
    cd "$TEST_DIR"
}

teardown() {
    cd "$ORIG_DIR"
    rm -rf "$TEST_DIR"
}

_make_case() {
    local id="$1"
    local file="$CASES_DIR/$2"
    cat >"$file" <<EOF
ID = "$id"
Title = "Sample test"
Automation = "Not automated"
EOF
}

@test "updates Automation and adds Automated_by for a single ID" {
    _make_case "TC-001" "tc001.toml"

    run bash "$SCRIPT" "TC-001"

    [ "$status" -eq 0 ]
    grep -q 'Automation = "Automated"' "$CASES_DIR/tc001.toml"
    grep -q 'Automated_by = "Vol"' "$CASES_DIR/tc001.toml"
}

@test "updates multiple IDs passed as comma-separated list" {
    _make_case "TC-002" "tc002.toml"
    _make_case "TC-003" "tc003.toml"

    run bash "$SCRIPT" "TC-002,TC-003"

    [ "$status" -eq 0 ]
    grep -q 'Automation = "Automated"' "$CASES_DIR/tc002.toml"
    grep -q 'Automation = "Automated"' "$CASES_DIR/tc003.toml"
}

@test "prints error message for unknown ID and continues" {
    _make_case "TC-004" "tc004.toml"

    run bash "$SCRIPT" "TC-UNKNOWN,TC-004"

    [ "$status" -eq 0 ]
    [[ "$output" == *"No file found for ID: TC-UNKNOWN"* ]]
    grep -q 'Automation = "Automated"' "$CASES_DIR/tc004.toml"
}

@test "preserves other fields in the file" {
    _make_case "TC-005" "tc005.toml"

    bash "$SCRIPT" "TC-005"

    grep -q 'ID = "TC-005"' "$CASES_DIR/tc005.toml"
    grep -q 'Title = "Sample test"' "$CASES_DIR/tc005.toml"
}

@test "no argument - runs without crashing" {
    run bash "$SCRIPT" ""
    [ "$status" -eq 0 ]
}
