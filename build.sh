#!/bin/bash
TEMPDIR=$(mktemp -d)
VERSION="${VERSION:=0.17.0}"
FLUX_CLI="${TEMPDIR}/flux"
UBER_MANIFEST_PATH="${TEMPDIR}/manifests.yaml"
function get_flux {
    os="linux"
    if [[ "$OSTYPE" == "darwin"* ]]; then
        os="darwin"
    fi
    URL="https://github.com/fluxcd/flux2/releases/download/v${VERSION}/flux_${VERSION}_${os}_amd64.tar.gz"
    wget -O "$TEMPDIR/flux.tgz" "$URL"
    tar -xzf "$TEMPDIR/flux.tgz" -C  "$TEMPDIR"
    echo $TEMPDIR
}

function get_manifests {
    $FLUX_CLI install --version $VERSION --export > $UBER_MANIFEST_PATH
}

get_flux
get_manifests
python3 $UBER_MANIFEST_PATH flux