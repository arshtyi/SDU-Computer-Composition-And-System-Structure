from __future__ import annotations

import shutil
from pathlib import Path


def main() -> None:
    """
    Copy every .bit file under experiment/ into bitstream/, keeping only
    the numeric directory segments from the original path.

    If the destination file already exists, it is skipped. A summary of
    copied (and skipped) files is printed at the end.
    """

    experiment_root = Path("experiment")
    bitstream_root = Path("bitstream")

    copied: list[Path] = []
    skipped: list[Path] = []

    if not experiment_root.exists():
        print("experiment/ not found, nothing to do.")
        return

    for bit_file in experiment_root.rglob("*"):
        if not bit_file.is_file() or bit_file.suffix.lower() != ".bit":
            continue

        relative = bit_file.relative_to(experiment_root)

        numeric_parts = [part for part in relative.parts[:-1] if part.isdigit()]
        dest = bitstream_root.joinpath(*numeric_parts, relative.name)

        if dest.exists():
            skipped.append(dest)
            continue

        dest.parent.mkdir(parents=True, exist_ok=True)
        shutil.copy2(bit_file, dest)
        copied.append(dest)

    if copied:
        print("Copied files:")
        for path in copied:
            try:
                print(f"- {path.relative_to(bitstream_root)}")
            except ValueError:
                print(f"- {path}")
    else:
        print("No files were copied.")

    if skipped:
        print("\nSkipped existing files:")
        for path in skipped:
            try:
                print(f"- {path.relative_to(bitstream_root)}")
            except ValueError:
                print(f"- {path}")


if __name__ == "__main__":
    main()
