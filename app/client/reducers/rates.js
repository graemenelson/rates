import { RECEIVED_RATES } from '../actions'

const rates = (state = {data: [], isFetching: false}, action) => {
  switch(action.type) {

    case RECEIVED_RATES:
      console.log(action)
      return state

    default:
      return state
  }
}

export default rates
