#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-2.0-or-later
#
# check_okf.sh — Verify OKF v0.1 conformance for docs/okf/ bundle.
#
# Usage: ./utils/CI/check_okf.sh [bundle_dir]
# Default bundle_dir: docs/okf (relative to repo root)

set -euo pipefail

ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
BUNDLE="${1:-$ROOT/docs/okf}"

if [[ ! -d "$BUNDLE" ]]; then
	echo "OKF bundle directory not found: $BUNDLE" >&2
	exit 1
fi

errors=0

has_frontmatter() {
	local file="$1"
	head -n 1 "$file" | grep -q '^---$'
}

extract_frontmatter_type() {
	local file="$1"
	awk '
		/^---$/ { if (++n == 1) next; if (n == 2) exit }
		n == 1 && /^type:/ { sub(/^type:[[:space:]]*/, ""); print; exit }
	' "$file"
}

check_concept() {
	local file="$1"
	local rel="${file#"$BUNDLE"/}"
	local base
	base="$(basename "$file")"

	if [[ "$base" == "index.md" || "$base" == "log.md" ]]; then
		return 0
	fi

	if ! has_frontmatter "$file"; then
		echo "ERROR: $rel — missing YAML frontmatter (required by OKF v0.1)" >&2
		errors=$((errors + 1))
		return
	fi

	local type_val
	type_val="$(extract_frontmatter_type "$file")"
	if [[ -z "$type_val" ]]; then
		echo "ERROR: $rel — frontmatter missing required non-empty 'type' field" >&2
		errors=$((errors + 1))
	fi
}

check_index() {
	local file="$1"
	local rel="${file#"$BUNDLE"/}"
	local base
	base="$(basename "$file")"
	local dir
	dir="$(dirname "$file")"

	if [[ "$base" != "index.md" ]]; then
		return 0
	fi

	# Root index.md may declare okf_version only.
	if [[ "$dir" == "$BUNDLE" ]]; then
		if has_frontmatter "$file"; then
			if ! grep -q '^okf_version:' "$file"; then
				echo "ERROR: $rel — root index.md frontmatter must declare okf_version" >&2
				errors=$((errors + 1))
			fi
			local extra_keys
			extra_keys="$(awk '
				/^---$/ { if (++n == 1) next; if (n == 2) exit }
				n == 1 && /^[^[:space:]]/ { print }
			' "$file" | grep -v '^okf_version:' || true)"
			if [[ -n "$extra_keys" ]]; then
				echo "ERROR: $rel — root index.md may only contain okf_version in frontmatter" >&2
				errors=$((errors + 1))
			fi
		fi
		return 0
	fi

	# Non-root index.md must not have frontmatter.
	if has_frontmatter "$file"; then
		echo "ERROR: $rel — index.md must not have frontmatter (except root okf_version)" >&2
		errors=$((errors + 1))
	fi
}

echo "Checking OKF conformance in: $BUNDLE"

while IFS= read -r -d '' file; do
	check_index "$file"
	check_concept "$file"
done < <(find "$BUNDLE" -name '*.md' -print0)

if [[ "$errors" -gt 0 ]]; then
	echo "OKF check failed with $errors error(s)." >&2
	exit 1
fi

echo "OKF check passed."
