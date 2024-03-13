#!/bin/bash
pushd $(dirname ${0}) > /dev/null || exit 1
./do-stop.sh
./do-clean.sh
./remove-snapshots.sh
./find-snapshot.sh
./do-start.sh
popd > /dev/null || exit 1
