import tabula

def pdf_to_latex_table(pdf_file, page):
    """Convert table in a PDF file to a LaTeX table."""
    tables = tabula.read_pdf(pdf_file, pages=page, output_format="dataframe")
    for table in tables:
        print(table.to_latex(index=False, escape=False))

# Example usage:
pdf_file = "relatorio.pdf"
page = 6
pdf_to_latex_table(pdf_file, page)
