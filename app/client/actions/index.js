import fetch from 'isomorphic-fetch'

export const CURRENCY_CLICK = 'CURRENCY_CLICK'
export const currencyClick = (currency) => {
  return dispatch => {
    dispatch({
      type: CURRENCY_CLICK,
      currency
    })
    dispatch(loadRates(currency))
  }
}

export const MORE_RATES_CLICK = 'MORE_RATES_CLICK'
export const moreRatesClick = (currency, lastDate) => {
  return {
    type: MORE_RATES_CLICK,
    currency,
    lastDate
  }
}

export const RECEIVED_RATES = 'RECEIVED_RATES'
function receivedRates(json) {
  return {
    type: RECEIVED_RATES,
    json: json
  }
}

// TODO: loadingRates and loadingMoreRates are different, so don't try and
// make them into one.
//
// loadingRates might returns something like:
// {
//   currency: 'USD',
//   // headers after date are in alphabetical order
//   headers: ['date', 'AUD', 'CAD', 'CHF', 'EUR', 'GBP', 'JPY', 'NZD'],
//   data: [
//     ['2017-02-01', 1.0566, 1.08773, ....],
//     ['2017-01-31', ....]
//   ],
//   loadMore: '/rates/USD?before=2017-01-15'
// }
//
// Actually, loadMoreRates can look the same, just don't really need headers, since they are
// already on the page
//
// But we might want to dispatch separate events for loading initial vs loading more,
// since the behavior of the UI is different.  Loading initial would replace the Rates
// Component with loading rates, load more mught just signal loading more but keeps
// existing rates on the page


function fetchRates(url) {
  return dispatch => {
    return fetch(`${url}.json`).then(response => response.json())
                               .then(json => dispatch(receivedRates(json)))
  }
}

function loadRates(currency) {
  return (dispatch, getState) => {
    return dispatch(fetchRates(`/rates/${currency}`))
  }
}
