import React, { PropTypes } from 'react'

const RatesHeader = ({headers}) => {
  const cells = headers.map(header => <th key={header}>{header}</th>)
  return (
    <thead>
      <tr>{cells}</tr>
    </thead>
  )
}

export default RatesHeader
