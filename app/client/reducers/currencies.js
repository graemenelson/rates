import { CURRENCY_CLICK } from '../actions'

const currencies = (state = {}, action) => {
  switch(action.type) {

    case CURRENCY_CLICK:
      return Object.assign({}, state, {selected: action.currency})

    default:
      return state
  }
}

export default currencies
