import { connect } from 'react-redux';
import { selectPokemonItem } from '../../reducers/selectors';
import ItemDetail from './item_detail';

const mapStateToProps = (state, ownProps) => ({
  item: selectPokemonItem(state, ownProps.match.params.itemId),
  ownProps: ownProps
});

export default connect(mapStateToProps)(ItemDetail);
