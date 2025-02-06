file_path = "src/bcd.mem"

with open(file_path, "w") as f:
    for i in range(64):
        # f.write(f"{i:06b} {(i // 10):04b} {(i % 10):04b}\n")
        f.write(f"{(i // 10):04b}{(i % 10):04b}\n")