import { connect } from 'react-redux';
import { withRouter } from 'react-router-dom';
import SessionForm from './session_form';
import { login, signup } from '../actions/session_actions';

const mapStateToProps = (state, ownProps) => ({
  loggedIn: Boolean(state.session.currentUser),
  errors: state.session.errors,
  formType: ownProps.location.pathname
});

const mapDispatchToProps = (dispatch, ownProps) => ({
  processForm: (user) => {
    if (ownProps.location.pathname === '/login') {
      return dispatch(login(user));
    } else if (ownProps.location.pathname === '/signup') {
      return dispatch(signup(user));
    }
  }
});

export default withRouter(
  connect(mapStateToProps, mapDispatchToProps)(SessionForm)
);
