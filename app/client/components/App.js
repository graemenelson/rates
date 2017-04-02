import styles from './App.scss'

import React from 'react'
import CurrenciesList from '../containers/CurrenciesList'
import RatesList from '../containers/RatesList'

const App = () => (
  <div className='app-container'>
    <CurrenciesList />
    <RatesList />
  </div>
)

export default App
