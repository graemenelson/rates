import { connect } from 'react-redux'
import Currencies from '../components/Currencies'
import { currencyClick } from '../actions'

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

const CurrenciesList = connect(
  mapStateToProps,
  mapDispatchToProps
)(Currencies)

export default CurrenciesList
