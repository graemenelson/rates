import React, { PropTypes } from 'react'

const buildCell = (val, idx) => {
  return (
    <td key={`td${idx}`}>{val}</td>
  )
}

const buildRow = (row, idx) => {
  const rowCells = row.map((val, idx) => buildCell(val, idx))
  return (
    <tr key={`tr${idx}`}>
      {rowCells}
    </tr>
  )
}

const RatesRows = ({rows}) => {
  const tableRows = rows.map((row, idx) => buildRow(row, idx))
  return (
    <tbody>
      {tableRows}
    </tbody>
  )
}

export default RatesRows
