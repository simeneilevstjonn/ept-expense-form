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
#show heading: set text(font: "Aptos", weight: "regular", fill: rgb("#2f5496"))

#set text(font: "Aptos")

#let expenseConfig = yaml("config.yaml")
#let expenses = yaml("expenses.yaml")

#let totalCost = expenses.expenses.map(expense => expense.cost).sum()
#let maximumCost = expenseConfig.equinorData.maximumReimbursementPerTeamMember * expenseConfig.team.len()


= Expense report per team member

== Team total
#table(
  columns: (50%, 50%),
  align: left,
  stroke: .5pt,
  [*Total expenses*], [#totalCost],
  [*Budget*], [#maximumCost],
  [*Budget utilisation*], [#calc.round(totalCost * 100 / maximumCost)%]
)

#let expenseToCells(expense) = {
  (
    [\[#expense.expenseType\] #expense.description],
    [#expense.cost]
  )
}

#for (member) in expenseConfig.team {
  [== #member.name]

  let memberExpenses = expenses.expenses.filter(expense => expense.reimburseToTeamMeber == member.name)

  if (memberExpenses.len() == 0) {
    [No expenses]
  }
  else {
    table(
      columns: (50%, 50%),
      align: left,
      stroke: .5pt,
      table.header([*Expense*],[*Cost*]),
      ..memberExpenses.map(expenseToCells).flatten(),
      [*Total*], [#memberExpenses.map(expense => expense.cost).sum()]
    )
    
  }  
}