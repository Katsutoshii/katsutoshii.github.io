+++
title = "Siphonowar"
template = "devlog.html"
insert_anchor_links = "right"
[extra]
weight = 1
+++

Here I document my work on Siphonowar, an RTS based in the bottom of the ocean floor where the player controls a complex organism called a Siphonophore.
I started this project to learn the [Bevy Game Engine](https://bevy.org).

## Spatial grid in Bevy

Most games require checking for neighboring entities and RTS games are no exception.
A naive approach to identify neighboring entities is to check all pairs of entities.
This is quadratic in time complexity, which is unacceptable for a game where the goal is several thousand simualted entities.
There are many common solutions to this problem, such as [k-d trees](https://en.wikipedia.org/wiki/K-d_tree).
I ended up going with a simpler approach of partitioning the space into a grid of fixed size.

Every grid in the game is specified by the following struct:

```rs
pub struct GridSpec {
    pub rows: u32,
    pub cols: u32,
    pub width: f32,
}
```

Given an xy position of an entity (where x, y are positive), we can compute its grid cell by:

```rs
impl GridSpec {
    pub fn discretize(&self, value: f32) -> Option<u32> {
        if value < 0.0 {
            return None;
        }
        Some((value / self.width) as u32)
    }
    pub fn to_rowcol(&self, mut position: Vec2) -> Option<RowCol> {
        position += self.offset();
        let res = (self.discretize(position.y)?, self.discretize(position.x)?);
        if self.in_bounds(res) {
            return Some(res);
        }
        None
    }
}
```

All neighboring cells can be computed by:
```rs
impl GridSpec {
    pub fn get_in_radius_discrete(&self, rowcol: RowCol, radius: u32) -> Vec<RowCol> {
        let (row, col) = rowcol;
        if !Self::in_bounds(self, rowcol) {
            return vec![];
        }
        let mut results = Vec::default();
        for other_row in self.cell_range(row, radius) {
            for other_col in self.cell_range(col, radius) {
                let other_rowcol = (other_row, other_col);
                if Self::in_radius(rowcol, other_rowcol, radius)
                    && Self::in_bounds(self, other_rowcol)
                {
                    results.push(other_rowcol)
                }
            }
        }
        results
    }
    pub fn in_radius(rowcol: RowCol, other_rowcol: RowCol, radius: u32) -> bool {
        let (row, col) = rowcol;
        let (other_row, other_col) = other_rowcol;
        let row_dist = row.abs_diff(other_row);
        let col_dist = col.abs_diff(other_col);
        row_dist * row_dist + col_dist * col_dist < radius * radius
    }
    fn cell_range(&self, center: u32, radius: u32) -> RangeInclusive<u32> {
        let (min, max) = (
            center.saturating_sub(radius),
            (center + radius).min(self.rows),
        );
        min..=max
    }
}
```


## Fog of war

I use a shader-based approach to build the fog of war for Siphonowar.
This is built on top of the grid system described above.
I maintain a grid where each cell stores whether a cell is unexplored, explored, or visible.

Whenever any entity moves, it updates the visibility grid of its previous neighbors and its new neighbors.
This state is copied to `visibility_texture`, which is accessed by a fragment shader.

This rendering of this grid looks like:

```wgsl
@group(2) @binding(0) var<uniform> color: vec4<f32>;
@group(2) @binding(1) var<uniform> size: GridSpec;

@group(2) @binding(2) var visibility_texture: texture_2d<f32>;
@group(2) @binding(3) var texture_sampler: sampler;

fn fog_noise(g: vec2<f32>) -> f32 {
    let path2 = vec2<f32>(-1.0, 0.33);
    let sin_t = sin(1.4 * globals.time);
    let sin_xt = sin(2.26 * globals.time);
    let noise1_xy = vec2<f32>(g.x + sin_t, g.y - sin_xt) * 0.2;
    let noise1 = perlin_noise_2d(noise1_xy);
    let noise2_xy = vec2<f32>(g.x + 0.2 * sin_xt, g.y + 0.5 * sin_t) * path2 * 0.2;
    let noise2 = perlin_noise_2d(noise2_xy);
    let noise = (noise1 + noise2) / 2;
    let noise_amount = 0.3;
    return noise_amount * max(noise, 0.);
}

@fragment
fn fragment(mesh: VertexOutput) -> @location(0) vec4<f32> {
    let g = grid_coords(size, mesh.world_position.xy);

    var output_color = color;

    var uv = mesh.uv;
    uv.y = 1.0 - uv.y;

    let e = 0.004;
    let fog_amount = textureSample9(visibility_texture, texture_sampler, uv, e).r;

    let alpha = 1.0 - fog_amount;
    output_color.a *= alpha + fog_noise(g);
    return output_color;
}
```

### Smoothing

To reduce flicker from entities moving back and forth on the boundary of two grid cells, I apply some manual temporal anti-aliasing by averaging the last three frames of the fog texture.

```wgsl
@group(2) @binding(0) var<uniform> color: vec4<f32>;
@group(2) @binding(1) var<uniform> size: GridSpec;

@group(2) @binding(2) var visibility_texture_a: texture_2d<f32>;
@group(2) @binding(3) var texture_sampler_a: sampler;

@group(2) @binding(4) var visibility_texture_b: texture_2d<f32>;
@group(2) @binding(5) var texture_sampler_b: sampler;

@group(2) @binding(6) var visibility_texture_c: texture_2d<f32>;
@group(2) @binding(7) var texture_sampler_c: sampler;

fn fog_noise(g: vec2<f32>) -> f32 {
    // ...
}

@fragment
fn fragment(mesh: VertexOutput) -> @location(0) vec4<f32> {
    let g = grid_coords(size, mesh.world_position.xy);

    var uv = mesh.uv;
    uv.y = 1.0 - uv.y;

    let e = 0.004;
    let fog_a = textureSample9(visibility_texture_a, texture_sampler_a, uv, e).r;
    let fog_b = textureSample9(visibility_texture_b, texture_sampler_b, uv, e).r;
    let fog_c = textureSample9(visibility_texture_c, texture_sampler_c, uv, e).r;
    var fog_amount = (fog_a + fog_b + fog_c) / 3.0;

    let alpha = 1.0 - fog_amount;
    output_color.a *= alpha + fog_noise(g);
    return output_color;
}
```
