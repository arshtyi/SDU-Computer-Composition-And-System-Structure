import os
import shutil


def find_bit_files(root):
    """递归查找root目录下所有.bit文件，返回文件的绝对路径列表"""
    bit_files = []
    for dirpath, _, filenames in os.walk(root):
        for fname in filenames:
            if fname.lower().endswith(".bit"):
                bit_files.append(os.path.join(dirpath, fname))
    return bit_files


def get_first_level_subdir(path, base):
    """获取path相对于base的第一级子目录名"""
    rel = os.path.relpath(path, base)
    parts = rel.split(os.sep)
    return parts[0] if len(parts) > 1 else None


def main():
    exp_dir = "experiment"
    bitstream_dir = "bitstream"
    copied = []

    bit_files = find_bit_files(exp_dir)
    for src in bit_files:
        # 获取第一级子目录
        subdir = get_first_level_subdir(src, exp_dir)
        if not subdir:
            continue  # 跳过没有一级子目录的情况
        dst_dir = os.path.join(bitstream_dir, subdir)
        os.makedirs(dst_dir, exist_ok=True)
        dst = os.path.join(dst_dir, os.path.basename(src))
        if os.path.exists(dst):
            continue  # 已存在则跳过
        shutil.copy2(src, dst)
        copied.append(f"{src} -> {dst}")

    print("复制完成，以下文件被复制：")
    for line in copied:
        print(line)


if __name__ == "__main__":
    main()
