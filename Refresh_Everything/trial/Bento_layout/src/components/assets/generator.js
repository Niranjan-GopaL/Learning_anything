import fs from 'fs';
import path from 'path';


const currentModuleUrl = new URL(import.meta.url);
const directoryPath = path.dirname(currentModuleUrl.pathname);


const imgFiles = fs.readdirSync(directoryPath).filter(file => file.endsWith('.png') || file.endsWith('.svg') );
const imageVariables = {};



imgFiles.forEach((imgFile, index) => {
  const imageName = `rect_${index + 1}`;
  const imagePath = `./${imgFile}`;

  imageVariables[imageName] = imagePath;
});



// THIS IS INSANE !!!!!
const imagesExport = `
${Object.entries(imageVariables).map(([key, value]) => `import ${key} from "${value}";`).join('\n')}

export const Rectangle = {
  ${Object.keys(imageVariables).map(key => `${key}: ${key},`).join('\n  ')}
};
`;

fs.writeFileSync('index.js', imagesExport, 'utf-8');

console.log('JavaScript file "index.js" created with image variables.!!!!!!!!!!!!');
