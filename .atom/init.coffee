{TextEditor} = require("atom")
cp = require("child_process")
path = require("path")
PDFViewer = require("#{atom.packages.resolvePackagePath("pdf-view")}/lib/pdf-editor-view")

atom.commands.add "atom-text-editor[data-grammar~=latex]", "reujab:openPDF", () ->
	for pane in atom.workspace.getPanes()
		console.log pane
		if pane.items[0] instanceof PDFViewer
			return pane.destroy()

	texPane = atom.workspace.getActivePane()
	pdfPath = getPDFPath()

	pdf = new PDFViewer(pdfPath, 1)
	pdfPane = atom.workspace.getActivePane().splitRight({items: [pdf]})
	texPane.activate()

	width = 612
	flexGrow = 1
	while pdfPane.element.clientWidth > width + 15
		flexGrow -= 0.01
		pdfPane.element.style.flexGrow = flexGrow

atom.commands.add "atom-text-editor[data-grammar~=latex]", "reujab:evince", () ->
	cp.spawn("evince", [getPDFPath()])

getPDFPath = () ->
	texPath = path.parse(atom.workspace.getActiveTextEditor().getPath())
	return "#{texPath.dir}/#{texPath.name}.pdf"
