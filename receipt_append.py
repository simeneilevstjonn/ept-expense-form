import yaml
import os
import subprocess

with open("expenses.yaml") as file:
    expenses = yaml.safe_load(file)

receipt_pdfs = []

for expense in expenses["expenses"]:
    receiptPath = os.path.join("receipts", expense["receipt"])
    if not receiptPath.endswith(".pdf"):
        subprocess.run(["convert", receiptPath, receiptPath + ".pdf"])
        receiptPath += ".pdf"

    receipt_pdfs.append(receiptPath)

subprocess.run([
    "gs",
    "-dBATCH",
    "-dNOPAUSE",
    "-q",
    "-sDEVICE=pdfwrite",
    "-dPDFSETTINGS=/prepress",
    "-sOutputFile=expense_form_with_receipts.pdf",
    "expense_form.pdf",
    *receipt_pdfs
])