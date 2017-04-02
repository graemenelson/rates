import React from 'react'

import thunkMiddleware from 'redux-thunk'
import { render } from 'react-dom'
import { Provider } from 'react-redux'
import { createStore, applyMiddleware } from 'redux'
import ratesApp from './reducers'
import App from './components/App'

const currencies = {
  available: ["AUD", "CAD", "CHF", "EUR", "GBP", "JPY", "NZD", "USD"],
  selected: ''
}
let store = createStore(ratesApp,
                        {currencies},
                        applyMiddleware(thunkMiddleware))

render(
  <Provider store={store}>
    <App />
  </Provider>,
  document.getElementById('rates-client')
)
