const fs = require("fs");

fs.rmSync("dist", { recursive: true, force: true });
fs.cpSync("src", "dist/src", { recursive: true });
fs.cpSync("styles", "dist/styles", { recursive: true });
console.log("Build complete: dist/");