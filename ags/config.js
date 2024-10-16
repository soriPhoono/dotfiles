const entry = `${App.configDir}/main.ts`
const output = `/tmp/ags`

try {
  console.log(`Building ${entry} -> ${output}/style.css`)

  Utils.exec([
    'sass', `${App.configDir}/style/main.scss`,
    `${output}/style.css`
  ])

  console.log(`Building ${entry} -> ${output}/main.js`)

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

export {}
