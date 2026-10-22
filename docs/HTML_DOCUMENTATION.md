# Maintaining the HTML Documentation

## Source of Truth

The [complete HTML documentation](DORKS_DILEMMA.html) pulls the repository's current Markdown guides, illustrated archive, code analysis, generated reference and historical investigation reports into one reading copy. It embeds the images, styling, reader controls and Mermaid diagram renderer, so you can open it straight in a browser without an internet connection.

**Edit the Markdown sources, never the generated HTML.** The generator doesn't keep a second copy of the prose. Each chapter links to its source file, and links between included documents become internal navigation. Links to source code and other repository files still need the checkout next to the HTML.

The document has a contents sidebar, chapter search, image enlargement and print support. Search filters documents by their full text. Historical reports are labelled as such and collapsed by default, because their old status claims and commands can contradict the current restoration guides. Printing expands them.

---

## Regeneration

The generator needs **Node.js 20 or later**. Its Markdown parser and browser diagram renderer live in `scripts/vendor/` with their licences. Generating the HTML doesn't use npm, install packages or download anything.

To rebuild the verified game, refresh the generated analysis and graphics sheets and generate the HTML:

```sh
make docs
```

This full refresh also needs the existing Python and cc65 build tools. If you're only changing documentation, use the current images and generated reference without rebuilding the game:

```sh
make docs-html
```

The direct equivalent is:

```sh
node scripts/build_docs.mjs
```

The output is `docs/DORKS_DILEMMA.html`. Commit the updated HTML together with the Markdown and asset changes, so readers can open it right away. The root README and the documentation index both link to it. Local SVG files in `docs/images/badges/` provide the README badges, because the generator rejects remote images.

### Watching Edits

```sh
make docs-watch
```

The watcher regenerates the HTML whenever Markdown, images, configuration or presentation templates change. Refresh the browser to see the result, and press Ctrl+C to stop. It doesn't rebuild the game or regenerate the code-analysis assets, so run `make docs` after changes that affect those inputs. Restart the watcher after adding a new source directory or changing the chapter configuration.

### Checking Freshness

```sh
make docs-check
make test-docs
```

The freshness check regenerates the expected output in memory and fails if the saved HTML is missing or stale. It compares source text, embedded image bytes, templates, configuration and renderer files, and it never overwrites the HTML. The documentation tests cover navigation, embedded assets, failure handling and source changes. The game regression checks are still available through `make test`.

If Node isn't on the normal executable path, pass its location to Make as `NODE`, for example `make docs-html NODE=/path/to/node`.

---

## Chapter Selection and Presentation

`docs/handbook.json` sets the chapter order and groups. It holds source paths and navigation settings, not copies of the documents. The project guide and reference sections list their Markdown inputs explicitly. Any other top-level Markdown file in `docs/` is picked up as a historical report, so add a new current guide to the explicit current list to give it the right status. Machine instructions such as `CLAUDE.md` are not chapters.

`scripts/build_docs.mjs` does the conversion. It namespaces headings by document so repeated titles stay distinct, rewrites links to included Markdown files, embeds local images and reports broken links. A broken link in a current document fails the build. Unresolved references in historical reports go into the HTML's embedded provenance record and are redirected to the chapter where possible. Source-file links in historical reports are kept even if their targets no longer exist.

The presentation shell is in `scripts/docs/handbook.html`, `scripts/docs/handbook.css` and `scripts/docs/handbook.js`. Change those files for layout or reader controls, then regenerate. Raw HTML in Markdown is escaped, and remote image dependencies are rejected. Mermaid code fences stay in the generated HTML as diagram source and render in the browser with the embedded library. The text is readable with JavaScript disabled, but the interactive controls and diagram rendering need it.

Generation is deterministic and has no build timestamp. The HTML's source revision is a SHA-256 digest of its input-file hashes, and a machine-readable `source-provenance` JSON block lists those hashes and any historical-link warnings. This verifies the inputs of the documentation snapshot. It says nothing new about the game build or gameplay testing.

---

## Third-Party Renderers

The generator uses [Marked](https://marked.js.org/) 17.0.5 for Markdown conversion. The HTML embeds [Mermaid](https://mermaid.js.org/config/usage.html) 10.9.3 for the existing diagrams. Their licence files sit beside the vendored libraries and are included in the HTML's notices. Both versions are pinned, so changing a renderer means regenerating the document and checking the result.
