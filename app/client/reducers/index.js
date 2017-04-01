import { combineReducers } from 'redux'
import currencies from './currencies'
import rates from './rates'

const ratesApp = combineReducers({
  currencies,
  rates
})

export default ratesApp
