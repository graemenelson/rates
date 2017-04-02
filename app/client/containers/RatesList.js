import { connect } from 'react-redux'
import Rates from '../components/Rates'
import { moreRatesClick } from '../actions'

const mapStateToProps = (state) => {
  return { rates: state.rates }
}

const mapDispatchToProps = (dispatch) => {
  return {
    onMoreRatesClick: (currency, lastDate) => {
      dispatch(moreRatesClick(currency, lastDate))
    }
  }
}

const RatesList = connect(
  mapStateToProps,
  mapDispatchToProps
)(Rates)

export default RatesList
