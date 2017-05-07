export const selectCurrency = (baseCurrency, rates) => {
  return {
    type: 'SWITCH_CURRENCY',
    baseCurrency,
    rates
  };
};

window.selectCurrency = selectCurrency;