#!/usr/bin/env bash

set -euo pipefail

# TODO: Ensure this is the correct GitHub homepage where releases can be downloaded for pre-commit.
GH_REPO="https://github.com/pre-commit/pre-commit"

fail() {
  echo -e "asdf-pre-commit: $*"
  exit 1
}

curl_opts=(-fsSL)

# NOTE: You might want to remove this if pre-commit is not hosted on GitHub releases.
if [ -n "${GITHUB_API_TOKEN:-}" ]; then
  curl_opts=("${curl_opts[@]}" -H "Authorization: token $GITHUB_API_TOKEN")
fi

sort_versions() {
  sed 'h; s/[+-]/./g; s/.p\([[:digit:]]\)/.z\1/; s/$/.z/; G; s/\n/ /' |
    LC_ALL=C sort -t. -k 1,1 -k 2,2n -k 3,3n -k 4,4n -k 5,5n | awk '{print $2}'
}

list_github_tags() {
  git ls-remote --tags --refs "$GH_REPO" |
    grep -o 'refs/tags/.*' | cut -d/ -f3- |
    sed 's/^v//' # NOTE: You might want to adapt this sed to remove non-version strings from tags
}

list_all_versions() {
  # TODO: Adapt this. By default we simply list the tag names from GitHub releases.
  # Change this function if pre-commit has other means of determining installable versions.
  list_github_tags
}

download_release() {
  local filename url
  filename="$1"
  url="$2"

  # TODO: Adapt the release URL convention for pre-commit
  curl "${curl_opts[@]}" -o "$filename" -C - "$url" || fail "Could not download $url"
}

install_version() {
  local install_type="$1"
  local version="$2"
  local install_path="$3"

  if [ "$install_type" != "version" ]; then
    fail "asdf-pre-commit supports release installs only"
  fi

  # TODO: Adapt this to proper extension and adapt extracting strategy.
  local release_file="pre-commit"
  local actualfilename="${release_file}-${version}.pyz"
  (

    echo "* Downloading pre-commit release $version..."
    local url sha256sumurl actualfilename actualsha256sumfilename
    mkdir -p "$install_path/bin"

    url="$GH_REPO/releases/download/v${version}/${actualfilename}"
    download_release "$actualfilename" "$url"

    local platform=$(uname | tr '[:upper:]' '[:lower:]')

    if [[ "x${platform}" = "xlinux" ]]; then
      actualsha256sumfilename="${actualfilename}.sha256sum"
      sha256sumurl="$GH_REPO/releases/download/v${version}/${actualsha256sumfilename}"
      download_release "$actualsha256sumfilename" "$sha256sumurl"
      if ! sha256sum -c "${actualsha256sumfilename}"; then
        rm -f "${actualfilename}" "${actualsha256sumfilename}" && fail "Checksum mismatch, download is incorrect!"
      else
        rm -f "${actualsha256sumfilename}" || echo "Could not delete the checksum file, this should not be a problem."
      fi
    fi

    local actual_install_path="${install_path}/bin/${actualfilename}"
    mv "${actualfilename}" "${actual_install_path}"
    # TODO: Asert pre-commit executable exists.
    local tool_cmd="pre-commit"
    local tool_cmd_full_path="$install_path/bin/$tool_cmd"
    chmod u+x "${actual_install_path}"
    ln -s "${actual_install_path}" "${tool_cmd_full_path}"
    test -x "${tool_cmd_full_path}" || fail "Expected ${tool_cmd_full_path} to be executable."

    echo "pre-commit $version installation was successful!"
  ) || (
    rm -rf "$install_path"
    fail "An error ocurred while installing pre-commit $version."
  )
}
