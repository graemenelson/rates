import styles from './Currencies.scss'

import React, { PropTypes } from 'react'
import Currency from './currency'

const Currencies = ({ currencies, onCurrencyClick }) => (
  <ul className="currencies">
    {currencies.available.map(curr =>
      <Currency value={curr}
                key={curr}
                onClick={() => onCurrencyClick(curr)}
                selected={currencies.selected === curr} />
    )}
  </ul>
)

Currencies.propTypes = {
  currencies: PropTypes.shape({
    available: PropTypes.arrayOf(PropTypes.string).isRequired,
    selected: PropTypes.string.isRequired
  }).isRequired,
  onCurrencyClick: PropTypes.func.isRequired
}

export default Currencies
