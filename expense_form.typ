// Mimic word
#set page(
  margin: (
    y: 25.5mm,
    x: 25.5mm
  ),
  paper: "a4",
  numbering: none,
)

#set heading(numbering: none)
#show heading: set text(font: "Arial", weight: "regular", fill: rgb("#2f5496"))

#set text(font: "Arial")

#let expenseConfig = yaml("config.yaml")
#let expenses = yaml("expenses.yaml")

#let totalCost = expenses.expenses.map(expense => expense.cost).sum()
#let maximumCost = expenseConfig.equinorData.maximumReimbursementPerTeamMember * expenseConfig.team.len()


= Travel Expense form for externals
Fill the form and send it to einord\@equinor.no. Remember to include all relevant receipts.
#linebreak()
#linebreak()


== Details of the person claiming the expenses:
#table(
  columns: (45.6mm, 113.6mm),
  align: left,
  [Full name:], [#expenseConfig.expenseClaimer.fullName],
  [Address:], [#expenseConfig.expenseClaimer.address],
  [Country:], [#expenseConfig.expenseClaimer.country],
  [Norwegian bank account number (11 digits):], [#expenseConfig.expenseClaimer.bankAccount],
  [Reason for trip:], [#expenseConfig.expenseClaimer.tripReason],
  [Start and end date:], [#expenseConfig.expenseClaimer.tripDates],
)
#linebreak()

== Team members included in claim
#table(
  columns: (50%, 50%),
  align: left,
  [Name], [Team],
  ..expenseConfig.team.map(member => (member.name, member.team)).flatten()
)
#linebreak()

#let expenseToCells(expense) = {
  (
    [\[#expense.expenseType\] #expense.description],
    [#expense.cost],
    [NOK]
  )
}

== Travel expenses
#table(
  columns: (33.33%, 33.33%, 33.33%),
  align: left,
  [What], [Cost], [Currency],
  ..expenses.expenses.map(expenseToCells).flatten(),
  [Total], [], [NOK]
)
#linebreak()

== Charge to account:
#table(
  columns: (33.33%, 33.33%, 33.33%),
  align: left,
  [G/L Account], [Cost Center /WBS], [Amount],
  [#expenseConfig.equinorData.glAccount],
  [#expenseConfig.equinorData.costCenter],
  [#calc.min(maximumCost, totalCost)],
)
#linebreak()

== Workflow receiver:
#table(
  columns: (33.33%, 33.33%, 33.33%),
  align: (center, left, left),
  [Eployee Number:], [Name:], [Office loc:],
  [#expenseConfig.equinorData.employeeNumber],
  [#expenseConfig.equinorData.employeeName],
  [#expenseConfig.equinorData.employeeOfficeLocation],
)
#linebreak()
Note: You need to use a bank account number that you own yourself. 