#!/usr/bin/env bash

set -euo pipefail

root="${HOME}/dotfiles/pacman/pkgbuild"

find "${root}" -type f -name ".SRCINFO" | while IFS= read -r srcinfo; do
    echo "Checking: ${srcinfo}"

    pkgver=""
    pkgbase=""
    url=""

    while IFS= read -r line; do
        # trim leading whitespace (tabs/spaces)
        line="${line#"${line%%[![:space:]]*}"}"

        case "${line}" in
            pkgver\ =\ *)
                pkgver="${line#pkgver = }"
                ;;
            pkgbase\ =\ *)
                pkgbase="${line#pkgbase = }"
                ;;
            url\ =\ *)
                url="${line#url = }"
                ;;
        esac
    done < "${srcinfo}"

    if [[ -z "${pkgver}" || -z "${pkgbase}" ]]; then
        echo "  skip: parsed empty values"
        echo "  debug pkgver='${pkgver}' pkgbase='${pkgbase}' url='${url}'"
        continue
    fi

    if [[ -z "${url}" ]]; then
        echo "  skip: missing url"
        continue
    fi

    case "${url}" in
        https://github.com/*) ;;
        *)
            echo "  skip: not github (${url})"
            continue
            ;;
    esac

    repo="${url#https://github.com/}"
    api="https://api.github.com/repos/${repo}/releases/latest"

    json="$(curl -fsSL "${api}" 2>/dev/null || true)"

    if [[ -z "${json}" ]]; then
        echo "  skip: no API response"
        continue
    fi

    latest="$(
        echo "${json}" \
        | grep -m1 '"tag_name"' \
        | cut -d'"' -f4
    )"

    if [[ -z "${latest}" ]]; then
        echo "  skip: no tag_name"
        continue
    fi

    clean_pkgver="${pkgver#v}"
    clean_latest="${latest#v}"

    if [[ "${clean_pkgver}" != "${clean_latest}" ]]; then
        echo "  OUTDATED: ${pkgbase}"
        echo "    local : ${pkgver}"
        echo "    latest: ${latest}"
    else
        echo "  OK: ${pkgbase} (${pkgver})"
    fi

done
