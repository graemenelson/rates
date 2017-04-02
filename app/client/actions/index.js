import fetch from 'isomorphic-fetch'

export const CURRENCY_CLICK = 'CURRENCY_CLICK'
export const currencyClick = (currency) => {
  return dispatch => {
    dispatch({
      type: CURRENCY_CLICK,
      currency
    })
    dispatch({
      type: RATES_REQUESTED,
      currency
    })
    dispatch(loadRates(currency))
  }
}

export const RATES_REQUESTED = 'RATES_REQUESTED'
export const RATES_RECEIVED  = 'RATES_RECEIVED'
function receivedRates(json) {
  return {
    type: RATES_RECEIVED,
    json: json
  }
}

function fetchRates(url) {
  return dispatch => {
    return fetch(`${url}.json`).then(response => response.json())
                               .then(json => dispatch(receivedRates(json)))
  }
}

function loadRates(currency) {
  return (dispatch, getState) => {
    // NOTE: using setTimeout to simulate some network/io wait, so we can show loading message
    return setTimeout(() => dispatch(fetchRates(`/rates/${currency}`)), 1250)
  }
}
