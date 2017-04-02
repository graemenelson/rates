import { RATES_RECEIVED, RATES_REQUESTED } from '../actions'

const rates = (state = {headers: [], rows: [], currency: null, isFetching: false}, action) => {
  switch(action.type) {

    case RATES_REQUESTED:
      return Object.assign({}, state, {isFetching: true, currency: action.currency})

    case RATES_RECEIVED:
      return Object.assign({}, state, action.json, {isFetching: false})

    default:
      return state
  }
}

export default rates
