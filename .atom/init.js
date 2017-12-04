/* globals atom */

const cp = require("child_process")
const path = require("path")
const PDFViewer = require(`${atom.packages.resolvePackagePath("pdf-view")}/lib/pdf-editor-view`)

atom.commands.add("atom-text-editor[data-grammar~=latex]", "reujab:openPDF", () => {
	for (const pane of atom.workspace.getPanes()) {
		if (pane.items[0] instanceof PDFViewer) {
			pane.destroy()
			return
		}
	}

	const texPane = atom.workspace.getActivePane()
	const pdfPane = texPane.splitRight({
		items: [new PDFViewer(getPDFPath(), 1)],
	})
	texPane.activate()

	const width = 612
	let flexGrow = 1
	while (pdfPane.element.clientWidth > width + 15) {
		flexGrow -= 0.01
		pdfPane.element.style.flexGrow = flexGrow
	}
})

atom.commands.add("atom-text-editor[data-grammar~=latex]", "reujab:evince", () => {
	cp.spawn("evince", [getPDFPath()])
})

function getPDFPath() {
	const texPath = path.parse(atom.workspace.getActiveTextEditor().getPath())
	return `${texPath.dir}/${texPath.name}.pdf`
}
