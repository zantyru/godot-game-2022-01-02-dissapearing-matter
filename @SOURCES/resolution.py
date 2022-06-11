TILE_SIZE = 20
INITIAL_W = 16
INITIAL_H = 9
RANGE_1_120 = range(1, 120+1)

resolutions = tuple((INITIAL_W*i, INITIAL_H*i) for i in RANGE_1_120)
tiles_count = tuple((w//TILE_SIZE, h//TILE_SIZE) for w, h in resolutions)

info = (
    f"{i+1:5}x {w:4}x{h:<5} - {u:3}x{v}"
    for i, ((w, h), (u, v)) in enumerate(zip(resolutions, tiles_count))
)

print(*info, sep="\n")
