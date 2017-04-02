import styles from './Rates.scss'

import React, { PropTypes } from 'react'

const Rates = ({rates, onMoreRatesClick}) => {
  const {data, isFetching} = rates

  if (data.length === 0 && !isFetching) {
    return (
      <div className='rates rates__empty'>
        <p>Please select a currency from above to load some rates</p>
      </div>
    )
  } else {
    return (
      <p> we have data or we are fetching </p>
    )
  }
}

export default Rates
