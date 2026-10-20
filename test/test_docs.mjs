import assert from 'node:assert/strict';
import fs from 'node:fs';
import os from 'node:os';
import path from 'node:path';
import { spawn } from 'node:child_process';
import { after, before, test } from 'node:test';
import { buildHandbook, writeHandbook, ROOT } from '../scripts/build_docs.mjs';

let root;
before(() => {
    root = fs.mkdtempSync(path.join(os.tmpdir(), 'dorks-docs-'));
    fs.cpSync(path.join(ROOT, 'scripts'), path.join(root, 'scripts'), { recursive: true });
    fs.mkdirSync(path.join(root, 'docs'), { recursive: true });
    fs.writeFileSync(path.join(root, 'docs/handbook.json'), JSON.stringify({
        output: 'docs/DORKS_DILEMMA.html', groups: [
            { id: 'guide', label: 'Guide', sources: ['README.md', 'docs/second.md'] },
            { id: 'history', label: 'History', historical: true, sources: [], discover: 'docs/*.md' },
        ],
    }));
    fs.writeFileSync(path.join(root, 'README.md'), '# First\n\n[Second](docs/second.md#repeat-1)\n\n![One dot](docs/dot.png)\n');
    fs.writeFileSync(path.join(root, 'docs/second.md'), '# Second\n\n## Repeat\n\nFirst section.\n\n## Repeat\n\nAnother section.\n\n[First](../README.md)\n');
    fs.writeFileSync(path.join(root, 'docs/old.md'), '# Old report\n\n[Gone](missing.md)\n');
    fs.writeFileSync(path.join(root, 'docs/dot.png'), Buffer.from('iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mP8/x8AAwMCAO+j2ioAAAAASUVORK5CYII=', 'base64'));
});
after(() => fs.rmSync(root, { recursive: true, force: true }));

test('rewrites cross-document links and duplicate headings without losing source navigation', () => {
    const { html } = buildHandbook(root);
    assert.match(html, /href="#docs--second--repeat-1"/);
    assert.match(html, /id="docs--second--repeat-1"/);
    assert.match(html, /href="#readme"/);
    assert.match(html, /href="second.md"/);
});

test('embeds images and renderer, with historical links explicitly classified', () => {
    const { html, warnings, sources } = buildHandbook(root);
    assert.match(html, /src="data:image\/png;base64,iVBOR/);
    assert.match(html, /class="document historical"/);
    assert.equal(warnings.length, 1);
    assert.match(warnings[0], /Missing repository file/);
    assert.deepEqual(sources, ['README.md', 'docs/second.md', 'docs/old.md']);
    assert.match(html, /connect-src 'none'/);
});

test('is deterministic and reports Markdown or image changes as stale', () => {
    const first = writeHandbook({ root });
    assert.equal(buildHandbook(root).html, first.html);
    assert.doesNotThrow(() => writeHandbook({ root, check: true }));
    const image = path.join(root, 'docs/dot.png');
    const original = fs.readFileSync(image);
    try {
        fs.appendFileSync(image, 'changed image bytes');
        assert.throws(() => writeHandbook({ root, check: true }), /is stale/);
    } finally { fs.writeFileSync(image, original); }
    const source = path.join(root, 'docs/second.md');
    const originalText = fs.readFileSync(source);
    try {
        fs.appendFileSync(source, '\nA new documented fact.\n');
        assert.throws(() => writeHandbook({ root, check: true }), /is stale/);
    } finally { fs.writeFileSync(source, originalText); }
});

test('fails on broken current links, missing images, and remote image dependencies', () => {
    const source = path.join(root, 'README.md');
    const original = fs.readFileSync(source);
    try {
        for (const [text, message] of [
            ['[Bad](docs/second.md#no-such-section)', /Missing section/],
            ['[Bad](does-not-exist.md)', /Missing repository file/],
            ['![Missing](not-here.png)', /ENOENT/],
            ['![Remote](https://example.com/image.png)', /Remote image/],
        ]) {
            fs.writeFileSync(source, `# First\n\n${text}\n`);
            assert.throws(() => buildHandbook(root), message);
        }
    } finally { fs.writeFileSync(source, original); }
});

test('escapes raw HTML from document content', () => {
    const source = path.join(root, 'README.md');
    const original = fs.readFileSync(source);
    try {
        fs.writeFileSync(source, '# First\n\n<script>alert("untrusted")</script>\n');
        const { html } = buildHandbook(root);
        assert.match(html, /&lt;script&gt;alert\(&quot;untrusted&quot;\)&lt;\/script&gt;/);
        assert.doesNotMatch(html, /<script>alert\("untrusted"\)<\/script>/);
    } finally { fs.writeFileSync(source, original); }
});

test('the complete repository handbook builds with all current links resolved', () => {
    const { html, sources, warnings } = buildHandbook();
    assert(sources.includes('docs/PUBLICATION_ARCHIVE.md'));
    assert(sources.includes('CODEBASE_ANALYSIS.md'));
    assert(sources.includes('docs/analysis/CODE_REFERENCE.md'));
    assert.match(html, /data:image\/svg\+xml;base64/);
    assert(warnings.every(warning => !warning.startsWith('CODEBASE_ANALYSIS.md:')));
    assert.equal((html.match(/class="document(?: historical)?"/g) || []).length, sources.length);
});

test('watch mode regenerates the saved handbook after a Markdown edit', async () => {
    const child = spawn(process.execPath, ['scripts/build_docs.mjs', '--watch'], { cwd: root });
    const waitForOutput = expected => new Promise((resolve, reject) => {
        const timeout = setTimeout(() => { cleanup(); reject(new Error(`Watcher did not report: ${expected}`)); }, 5000);
        function cleanup() { clearTimeout(timeout); child.stdout.off('data', onData); }
        function onData(data) { if (data.toString().includes(expected)) { cleanup(); resolve(); } }
        child.stdout.on('data', onData);
    });
    const source = path.join(root, 'docs/second.md');
    const original = fs.readFileSync(source);
    try {
        await waitForOutput('Watching Markdown');
        const rebuilt = waitForOutput('Generated docs/DORKS_DILEMMA.html');
        fs.appendFileSync(source, '\nWatch mode acceptance marker.\n');
        await rebuilt;
        assert.match(fs.readFileSync(path.join(root, 'docs/DORKS_DILEMMA.html'), 'utf8'), /Watch mode acceptance marker/);
    } finally {
        child.kill();
        fs.writeFileSync(source, original);
    }
});
