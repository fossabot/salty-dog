import { safeDump, safeLoadAll } from 'js-yaml';

import { CONFIG_SCHEMA } from 'src/config/schema';
import { Parser } from 'src/parser';

export class YamlParser implements Parser {
  dump(...data: Array<any>): string {
    const docs: Array<any> = [];
    for (const doc of data) {
      const part = safeDump(doc, {
        schema: CONFIG_SCHEMA,
      });
      docs.push(part);
    }
    return docs.join('\n---\n\n');
  }

  parse(body: string): Array<any> {
    const docs: Array<any> = [];
    safeLoadAll(body, (doc: any) => docs.push(doc), {
      schema: CONFIG_SCHEMA,
    });
    return docs;
  }
}