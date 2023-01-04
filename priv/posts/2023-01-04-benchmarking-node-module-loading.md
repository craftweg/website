---
title: Benchmarking module loading and requiring in NodeJS
description:
categories: [node, javascript, esm, commonjs]
---


As I brought up [a few weeks ago](/blog/2022/12/23/startup-time-in-node-clis),
statically loading ESM modules can lead to a CLI that's slow to launch.
If you find yourself already in a position where your CLI is slow,
Node doesn't provide tools to discover where the bottleneck might be.
This motivated me to build a tiny [node-module-benchmarker](https://github.com/pepicrft/node-module-benchmarker) that wraps the execution of Node subscribing to `require` and `import` calls and exporting a JSON file that we can open with the Chrome tracing tool, [chrome://tracing](chrome://tracing).

If you want to use it,
all you need to do is to install the dependency,
either globally or as a dependency of your project,
and execute it as a replacement of the `node` executable.
You'll have to pass the output path with the environment variable `BENCHMARK_OUTPUT_PATH`.

```language-bash
BENCHMARK_OUTPUT_PATH=benchmark.json pnpm exec node-module-benchmarker src/index.js
```

I'm still iterating on the output format because it's difficult to parse visually.
If you have ideas for alternative profiling frontends I'd love to hear them.
