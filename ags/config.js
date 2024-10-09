const entry = `${App.configDir}/ts/main.ts`
const output = `/tmp/ags/js`

try {
    await Utils.execAsync([
        'esbuild', '--bundle', entry,
        '--format=esm',
        `--outfile=${output}/main.js`,
        '--external:resource://*',
        '--external:gi://*',
        '--external:file://*',
    ])

    await import(`file://${output}/main.js`)
} catch (error) {
    console.error(error)
}