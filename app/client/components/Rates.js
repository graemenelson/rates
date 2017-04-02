import styles from './Rates.scss'

import React, { PropTypes } from 'react'
import RatesHeader from './RatesHeader'
import RatesRows from './RatesRows'

const renderIsFetching = (currency) => {
  return (
    <div className='rates rates__loading'>
      <p>Loading data for <strong>{currency}</strong></p>
    </div>
  )
}

const renderNoCurrency = () => {
  return (
    <div className='rates rates__initial'>
      <p>Please select a currency from above to load some rates</p>
    </div>
  )
}

const renderNoData = (currency) => {
  return (
    <div className='rates rates__empty'>
      <p>No rates were found for <strong>{currency}</strong>, try back in a few minutes</p>
    </div>
  )
}

const renderData = (headers, rows) => {
  return (
    <div className='rates rates__present'>
      <table>
        <RatesHeader headers={headers} />
        <RatesRows rows={rows} />
      </table>
    </div>
  )
}

const Rates = ({currency, headers, rows, isFetching}) => {

  if (!currency) {
    return renderNoCurrency()
  } else if (rows.length === 0 && !isFetching) {
    return renderNoData(currency)
  } else if (isFetching) {
    return renderIsFetching(currency)
  } else {
    return renderData(headers, rows)
  }
}

export default Rates
