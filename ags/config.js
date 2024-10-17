const entry = `${App.configDir}/main.ts`
const output = `/tmp/ags`

try {
  console.log(`Building ${output}`)

  await Utils.execAsync(
    `bash -c "if [[ ! -d ${output} ]]; then mkdir ${output}; fi"`
  ).catch(console.error)

  console.log(`Building ${entry} -> ${output}/style.css`)

  await Utils.execAsync([
    'sass', `${App.configDir}/style/main.scss`,
    `${output}/style.css`
  ]).catch(console.error)

  console.log(`Building ${entry} -> ${output}/main.js`)

  await Utils.execAsync([
    'esbuild', '--bundle', entry,
    '--format=esm',
    `--outfile=${output}/main.js`,
    '--external:resource://*',
    '--external:gi://*',
    '--external:file://*',
  ]).catch(console.error)

  await import(`file://${output}/main.js`)
} catch (error) {
  console.error(error)
}

export {}
