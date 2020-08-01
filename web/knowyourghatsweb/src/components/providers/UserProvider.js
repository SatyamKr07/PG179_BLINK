import React, { Component, createContext } from "react";
import { auth , generateUserDocument } from "../../firebase";
import history from "../../history";

export const UserContext = createContext({ user: null });
class UserProvider extends Component {
    state = { user: null };
    componentDidMount = async () => {
        auth.onAuthStateChanged(async userAuth => {
          const user = await generateUserDocument(userAuth);
          this.setState({ user });
          if(user)
          {
              history.push("/home");
          } else 
          {
              history.push("/");
          }
          //console.log(user);
        });
      };

  render() {
    return (
      <UserContext.Provider value={this.state.user}>
        {this.props.children}
      </UserContext.Provider>
    );
  };
}
export default UserProvider;