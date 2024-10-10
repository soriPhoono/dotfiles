const entry = `${App.configDir}/ts/main.ts`
const output = `/tmp/ags/js`

try {
  Utils.exec([
    'sass', `${App.configDir}/style/main.scss`,
    `${output}/style.css`
  ])

  Utils.exec([
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
