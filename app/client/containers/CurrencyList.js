import { connect } from 'react-redux'
import Currencies from '../components/Currencies'

// TODO: move into actions
const currencyClick = (currency) => {
  return {
    type: 'CURRENCY_CLICK',
    currency
  }
}

const mapStateToProps = (state) => {
  return { currencies: state.currencies }
}

const mapDispatchToProps = (dispatch) => {
  return {
    onCurrencyClick: (currency) => {
      dispatch(currencyClick(currency))
    }
  }
}

const CurrencyList = connect(
  mapStateToProps,
  mapDispatchToProps
)(Currencies)

export default CurrencyList
