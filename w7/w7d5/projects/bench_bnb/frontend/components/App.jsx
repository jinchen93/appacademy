import React from "react";
import { Route } from "react-router-dom";

import GreetingContainer from "./greeting_container";
import SessionFormContainer from "./session_form_container";
import SearchContainer from "./search_container";
import BenchFormContainer from "./bench_form_container";
import { AuthRoute } from "../util/route_util";

const App = () => (
  <div>
    <nav>
      <h1>BenchBnB</h1>
      <GreetingContainer />
    </nav>
    <Route exact path="/benches/new" component={BenchFormContainer} />
    <AuthRoute path="/login" component={SessionFormContainer} />
    <AuthRoute path="/signup" component={SessionFormContainer} />

    <Route exact path="/" component={SearchContainer} />
  </div>
);

export default App;
