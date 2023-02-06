const fs = require('fs');

// Read file and add line numbers
const readFile = (fileName: string) => {
    return new Promise((resolve, reject) => {
        fs.readFile(fileName, 'utf8', (err: any, data: string) => {
            if (err) {
                reject(err);
            } else {
                let lines = data.split('\n');
                let result = '';
                for (let i = 0; i < lines.length; i++) {
                    result += `${i + 1}. ${lines[i]}\n`;
                }
                resolve(result);
            }
        });
    });
};

// Write to file
const writeFile = (fileName: string, data: string) => {
    return new Promise<void>((resolve, reject) => {
        fs.writeFile(fileName, data, (err: any) => {
            if (err) {
                reject(err);
            } else {
                resolve();
            }
        });
    });
};

// Main function
async function main() {
    try {
        const fileName = '/Users/thiagosouza/POLI/labdig1/digital_laboratory_i/exps/03/sim/circuito_exp3.vhd';
        const newFileName = 'sample_with_line_numbers.txt';
        const data = await readFile(fileName);
        await writeFile(newFileName, data as string);
        console.log(`File ${fileName} has been copied and line numbers added to ${newFileName}.`);
    } catch (err) {
        console.error(err);
    }
}

main();