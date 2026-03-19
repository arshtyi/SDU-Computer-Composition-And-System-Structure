from pathlib import Path
import shutil


def _unique_target_path(target: Path) -> Path:
    """Return a non-conflicting path by appending an index if needed."""
    if not target.exists():
        return target

    stem = target.stem
    suffix = target.suffix
    parent = target.parent
    index = 1
    while True:
        candidate = parent / f"{stem}_{index}{suffix}"
        if not candidate.exists():
            return candidate
        index += 1


def copy_bitstreams(experiment_dir: Path, bitstream_dir: Path) -> int:
    """
    Copy all .bit files under experiment_dir recursively into bitstream_dir,
    grouped by the first-level directory under experiment_dir.
    """
    copied_count = 0

    for bit_file in experiment_dir.rglob("*.bit"):
        relative = bit_file.relative_to(experiment_dir)
        parts = relative.parts
        first_level = parts[0] if parts else "root"

        target_dir = bitstream_dir / first_level
        target_dir.mkdir(parents=True, exist_ok=True)

        target_path = _unique_target_path(target_dir / bit_file.name)
        shutil.copy2(bit_file, target_path)
        copied_count += 1

    return copied_count


def main() -> None:
    base_dir = Path(__file__).resolve().parent
    experiment_dir = base_dir / "experiment"
    bitstream_dir = base_dir / "bitstream"

    if not experiment_dir.exists() or not experiment_dir.is_dir():
        print(f"Source directory not found: {experiment_dir}")
        return

    bitstream_dir.mkdir(parents=True, exist_ok=True)
    copied = copy_bitstreams(experiment_dir, bitstream_dir)
    print(f"Copied {copied} .bit file(s) to: {bitstream_dir}")


if __name__ == "__main__":
    main()
