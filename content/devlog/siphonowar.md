+++
title = "Siphonowar"
template = "devlog.html"
insert_anchor_links = "right"
[extra]
weight = 1
+++

Here I document my work on Siphonowar, an RTS based in the bottom of the ocean floor where the player controls a complex organism called a Siphonophore.
I started this project to learn the [Bevy Game Engine](https://bevy.org).

## Fog of war

```wgsl
@group(2) @binding(0) var<uniform> color: vec4<f32>;
@group(2) @binding(1) var<uniform> size: GridSpec;

@group(2) @binding(2) var visibility_texture_a: texture_2d<f32>;
@group(2) @binding(3) var texture_sampler_a: sampler;

@group(2) @binding(4) var visibility_texture_b: texture_2d<f32>;
@group(2) @binding(5) var texture_sampler_b: sampler;

@group(2) @binding(6) var visibility_texture_c: texture_2d<f32>;
@group(2) @binding(7) var texture_sampler_c: sampler;

@fragment
fn fragment(mesh: VertexOutput) -> @location(0) vec4<f32> {
    let g = grid_coords(size, mesh.world_position.xy);

    let path2 = vec2<f32>(-1.0, 0.33);

    var output_color = color;
    let sin_t = sin(1.4 * globals.time);
    let sin_xt = sin(2.26 * globals.time);
    let noise1_xy = vec2<f32>(g.x + sin_t, g.y - sin_xt) * 0.2;
    let noise1 = perlin_noise_2d(noise1_xy);
    let noise2_xy = vec2<f32>(g.x + 0.2 * sin_xt, g.y + 0.5 * sin_t) * path2 * 0.2;
    let noise2 = perlin_noise_2d(noise2_xy);
    let noise = (noise1 + noise2) / 2;
    let noise_amount = 0.3;

    var uv = mesh.uv;
    uv.y = 1.0 - uv.y;

    let e = 0.004;
    let fog_a = textureSample9(visibility_texture_a, texture_sampler_a, uv, e).r;
    let fog_b = textureSample9(visibility_texture_b, texture_sampler_b, uv, e).r;
    let fog_c = textureSample9(visibility_texture_c, texture_sampler_c, uv, e).r;
    var fog_amount = (fog_a + fog_b + fog_c) / 3.0;

    let alpha = 1.0 - fog_amount;
    output_color.a *= alpha + noise_amount * max(noise, 0.);
    return output_color;
}
```

