// I genuinely believe that pug-cli is broken when compiling for client.
// why the hell wouldn't it export a function? How am I supposed to use the compiled file?
// Anyway, this is an easy enough fix.
// We just use the pug library to compile the template, and then export the generated function.
import fs from 'node:fs';
import path from 'node:path';
import pug from 'pug'

const templatesDir = path.join('oscars-pool/src/templates');

fs.readdir(templatesDir, (err, files) => {
  if (err) throw err;

  files.forEach(file => {
    if (path.extname(file) === '.pug') {
      const filePath = path.join(templatesDir, file);
      const outputFile = path.join(templatesDir, path.basename(file, '.pug') + '.js');
      const compiledFunction = pug.compileFile(filePath);
      const wrappedData = `${compiledFunction}; export default template;`;
      fs.writeFile(outputFile, wrappedData, 'utf8', err => {
        if (err) throw err;
        console.log(`Wrapped and exported ${file}`);
      });
    }
  });
});
