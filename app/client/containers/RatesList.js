import { connect } from 'react-redux'
import Rates from '../components/Rates'
import { moreRatesClick } from '../actions'

const mapStateToProps = (state) => {
  return state.rates
}

const RatesList = connect(
  mapStateToProps
)(Rates)

export default RatesList
