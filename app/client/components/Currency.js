import styles from './Currency.scss'
import React, { PropTypes } from 'react'

const Currency = ({value, onClick, selected}) => (
  <li onClick={onClick}
      className={selected ? 'currencies__item currencies__item--selected' : 'currencies__item'}>
    {value}
  </li>
)

Currency.propTypes = {
  value: PropTypes.string.isRequired,
  onClick: PropTypes.func.isRequired,
  selected: PropTypes.bool.isRequired
}

export default Currency
