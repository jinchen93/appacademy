export const SWITCH_CURRENCY = 'SWITCH_CURRENCY';

const selectCurrency = (baseCurrency, rates) => {
  return {
    type: SWITCH_CURRENCY,
    baseCurrency,
    rates
  };
};

export default selectCurrency;